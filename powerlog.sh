#!/bin/bash

#./cpu/cpuLogToFile 1 t & sleep 10; kill $!

# ./cpu/cpuLogToFile 1 t & 
# export cpulog_PID=$!

# ./gpu/gpuToFIle 1 t &
# export gpulog_PID=$!

# sleep 10;
# kill cpulog_PID
# kill gpulog_PID


# trap 'kill %1' SIGINT
# ./gpu/gpuToFIle $1 $2 & ./cpu/cpuLogToFile $1 $2   

echo start measuring 
date


trap 'kill %1, kill %2' SIGINT
./cpu/cpuLogToFile 1 test 10 &  

python ./gpu/gpuProfiling.py 1 test 10 &

#user program command goes here 
python ./user_code.py 

sudo pkill cpuLogToFile
sudo pkill -f ./gpu/gpuProfiling.py

#The measurement will end when $3 time out or user program returns or terminated by the keyboard 'Ctrl + C' 

date
echo end measuring
