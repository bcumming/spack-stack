-include ../Make.user

MAKEFLAGS += --output-sync=recurse

GCC_PREFIX = $$($(SPACK) -e ../compilers/2-gcc find --format '{prefix}' gcc@11)

.PHONY: all .locks

all: nvhpc/generated/env tools/generated/env

# Make sure spack.lock files are never removed as intermediate files...
.locks: nvhpc/spack.lock tools/spack.lock

tools/config.yaml nvhpc/config.yaml : | store
	$(SPACK) config --scope=user add config:install_tree:root:$(STORE)

nvhpc/compilers.yaml:
	$(SPACK) compiler find --scope=user $(call compiler_bin_dirs, $(GCC_PREFIX))
	$(SPACK) compiler find /mch-environment/devt/nvidia

tools/compilers.yaml:
	$(SPACK) compiler find --scope=user $(call compiler_bin_dirs, $(GCC_PREFIX))

-include ../Make.inc

ifeq (,$(filter clean,$(MAKECMDGOALS)))
include nvhpc/Makefile
include tools/Makefile
endif
