cp /scratch/e1000/meteoswiss/scratch/bcumming/tarballs/nvhpc_nightly_230206_Linux_x86_64_cuda_multi.tar.gz .
tar -xzf nvhpc_nightly_230206_Linux_x86_64_cuda_multi.tar.gz
mkdir -p nightly/store/nvidia/23.3
cp -R hpc_sdk/Linux_x86_64/dev/* nightly/store/nvidia/23.3

cd nightly

# edit config/compilers.yaml
# edit compilers/llvm/compilers.yaml

# edit packages/nvhpc/compilers.yaml
```
- compiler:
    spec: nvhpc@23.3
    paths:
      cc:  /mch-environment/devt/nvidia/23.3/compilers/bin/nvc
      cxx: /mch-environment/devt/nvidia/23.3/compilers/bin/nvc++
      f77: /mch-environment/devt/nvidia/23.3/compilers/bin/nvfortran
      fc:  /mch-environment/devt/nvidia/23.3/compilers/bin/nvfortran
    flags: {}
    operating_system: sles15
    target: x86_64
    modules: []
    environment: {}
    extra_rpaths: []
```

pals_get_nic_distances

mkdir -p spack-stack/store/nvidia/23.3
cp -R hpc_sdk/Linux_x86_64/dev/* spack-stack/store/nvidia/23.3

git clone git@github.com:spack/spack.git
(cd spack; git checkout a8b1314d188149e696eb8e7ba3e4d0de548f1894)
git checkout balfrin-nightly
./configure

env --ignore-environment PATH=/usr/bin:/bin:`pwd`/spack/bin make generate-config j64

env --ignore-environment PATH=/usr/bin:/bin:`pwd`/spack/bin make packages j64
vim packages/nvhpc/compilers.yaml
# add the nvhpc compiler spec above to the file

env --ignore-environment PATH=/usr/bin:/bin:`pwd`/spack/bin make packages j64

vim store/config/compilers.yaml
# add the nvhpc compiler spec above to the file

env --ignore-environment PATH=/usr/bin:/bin:`pwd`/spack/bin make modules j64


generate-config has to "find" the nvhpc compiler (or we patch store/config/compilers.yaml manually)
