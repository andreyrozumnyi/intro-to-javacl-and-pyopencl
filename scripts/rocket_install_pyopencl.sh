#!/bin/bash

# A script to install pyopencl on rocket.hpc.ut.ee

# Load modules
module load python-3.4.0
module load gcc-4.8.1

cd $HOME
mkdir pyopencl
cd pyopencl/
wget https://pypi.python.org/packages/source/p/pyopencl/pyopencl-2015.1.tar.gz
tar xfz pyopencl-2015.1.tar.gz
cd pyopencl-2015.1

# Download OpenCL 2.1 headers
mkdir -p include/CL
cd include/CL
wget https://www.khronos.org/registry/cl/api/2.1/{opencl,cl_platform,cl,cl_ext,cl_gl,cl_gl_ext}.h
cd ../..

# add six as install requirement to pyopencl
sed -i -- 's/"pytools>=2014.2",/"six>=1.4.0","pytools>=2014.2",/g' setup.py

# configure to use the downloaded headers
python configure.py --cl-inc-dir="$(pwd)/include" --cl-lib-dir=$HOME/AMDAPPSDK-3.0/lib/x86_64/
python setup.py install --user
