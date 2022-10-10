#! /usr/bin/bash

recipe_path="$(pwd)/recipe"
cp ${recipe_path}/Make.user .

for target in gcc tools nvhpc
do
    recipe="${recipe_path}/${target}.spack.yaml"
    if [ -f "${recipe}" ]
    then
        echo "=== setting custom ${target} packages: ${recipe}"
        cp "${recipe}" packages/${target}/spack.yaml
    fi
done

mkdir -p module-config
rm -rf module-config/*
for config in modules upstream
do
    recipe="${recipe_path}/${config}.yaml"
    if [ -f "${recipe}" ]
    then
        echo "=== setting custom modules configuration: ${recipe}"
        cp "${recipe}" module-config
    fi
end

echo "=== patching cray-mpich-binary spack package"

mkdir -p spack/var/spack/repos/builtin/packages/cray-mpich-binary
cp cray-mpich-binary-package.py spack/var/spack/repos/builtin/packages/cray-mpich-binary/package.py

echo "==== WARNING - we need to create an upstreams.yaml"
