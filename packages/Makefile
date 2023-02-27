-include ../Make.user

MAKEFLAGS += --output-sync=recurse

GCC_PREFIX = $$($(SPACK) -e ../compilers/2-gcc find --format '{prefix}' gcc@11)
NVHPC_PREFIX = $$($(SPACK) -e ../compilers/3-llvm find --format '{prefix}' nvhpc)

.PHONY: all .locks

all: gcc/generated/env tools/generated/env nvhpc/generated/env

# Make sure spack.lock files are never removed as intermediate files...
.locks: gcc/spack.lock tools/spack.lock nvhpc/spack.lock

gcc/config.yaml tools/config.yaml nvhpc/config.yaml: | store
	$(SPACK) config --scope=user add config:install_tree:root:$(STORE)

gcc/compilers.yaml:
	$(SPACK) compiler find --scope=user $(call compiler_bin_dirs, $(GCC_PREFIX))

nvhpc/compilers.yaml:
	$(SPACK) compiler find --scope=user $(call compiler_bin_dirs, $(NVHPC_PREFIX) $(GCC_PREFIX))

tools/compilers.yaml:
	$(SPACK) compiler find --scope=user $(call compiler_bin_dirs, $(GCC_PREFIX))

-include ../Make.inc

ifeq (,$(filter clean,$(MAKECMDGOALS)))
include gcc/Makefile
include nvhpc/Makefile
include tools/Makefile
endif
