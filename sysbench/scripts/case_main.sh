#!/bin/bash

for i in {0..10}
do
THREADS=`echo 2^$i | bc`
sh case_comm.sh $i $THREADS
done