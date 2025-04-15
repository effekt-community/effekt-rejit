# A very simple regex JIT in Effekt

> **LLVM only**: This only works for the LLVM backend.

> **ARM64 only**: This only works on 64-bit arm.

This is a very simple derivative-based regex implementation, JITting individual transitions.

This is a proof-of-concept for writing a JIT in Effekt.