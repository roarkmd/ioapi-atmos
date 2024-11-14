#!/bin/csh

source ./IOAPI.config.csh
module purge
module load intel/24.2

cd $IOAPI_HOME
make clean
make all >& compile.$BIN.log
