# Compile c files to includable llvm files
%.ll: %.c
	bash ./c_to_llvm_include.sh $< $@