#!/bin/bash

# First, get relevant file paths
C_FILE="$1"
if [ -n "$2" ]; then
    OUT_FILE="$2"
    TMP_FILE="${OUT_FILE%.ll}.tmp.ll"
else
    FILE_BASE="${C_FILE%.c}"
    OUT_FILE="$FILE_BASE.ll"
    TMP_FILE="$FILE_BASE.tmp.ll"
fi

# Run clang to generate LLVM IR and have opt remove some stuff we don't want there
clang -S -emit-llvm "$C_FILE" -o - | opt -strip-debug -strip-named-metadata -S -o "$TMP_FILE"

# Now use awk for some additional postprocessing, removing metadata lines and doing minor cleanup
awk 'BEGIN {
    # First pass to collect attributes
    pass = 1
}

# First pass: collect all attribute definitions
pass == 1 && /^attributes #[0-9]+ = / {
    attr_id = $2;  # "attributes #N"
    attr_def = substr($0, index($0, "= ") + 2);  # everything after "= "

    # Remove some attributes that might lead to problems
    gsub(/"target-[^"]*"="[^"]*"/, "", attr_def);
    gsub(/"stack-protector-buffer-size"="[0-9]*"/, "", attr_def);

    # Clean up any double spaces created by the removal
    gsub(/  +/, " ", attr_def);
    gsub(/ }/, "}", attr_def);
    gsub(/{ /, "{", attr_def);

    # Remove braces from attr_def
    gsub(/^{/, "", attr_def);
    gsub(/}$/, "", attr_def);

    attributes[attr_id] = attr_def;
}

# When we reach the end of file in first pass
END {
    if (pass == 1) {
        # Reset file pointer for second pass
        pass = 2;
        cmd = "cat " ARGV[1];
        blank_line = 1;  # Flag to track leading blank lines
        while ((cmd | getline) > 0) {
            # Skip attribute definition lines
            if ($0 ~ /^attributes #[0-9]+ = /)
                continue;

            # Skip some metadata lines
            if ($0 ~ /^; ModuleID = /) continue;
            if ($0 ~ /^source_filename = /) {
                split($0, parts, "=");
                if (length(parts) > 1) {
                    value = substr($0, index($0, "=") + 1);
                    gsub(/^[[:space:]]+|[[:space:]]+$/, "", value);  # Trim leading/trailing spaces
                    print ";;; generated from " value;
                }
                continue;
            }
            if ($0 ~ /^target [a-z]* = /) continue;

            # Skip definition of Pos
            if ($0 ~ /^%struct\.Pos = */) continue;

            # Drop leading blank lines
            if (blank_line && $0 ~ /^[[:space:]]*$/) continue;
            else blank_line = 0;

            line = $0;
            # Replace attribute references
            for (attr_id in attributes) {
                gsub(attr_id, attributes[attr_id], line);
            }

            # Replace struct.Pos
            gsub(/struct\.Pos/, "Pos", line);
            
            print line;
        }
        close(cmd);
    }
}' "$TMP_FILE" > "$OUT_FILE"

rm "$TMP_FILE"