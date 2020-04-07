#!/bin/bash

# author: Csoyee
# assume that you have already prebuild docker image named $1 
IMAGE_TAG=$1
CONTAINER_NAME=$2
CWD=`pwd`
DATA_DIR=$3
ROCKSDB_DIR=$4

if [ $# -lt 3 ]
then
	echo "Usage: $0 [IMAGE TAG] [CONTAINER NAME] [DATA DIR]"
	exit 1
fi

print_usage(){
        echo "----"
            
        echo "load rocksdb data"
        echo "방법1: 이미 로딩한거 cp "
        echo " 방법2: ycsb load command 사용 (아래 run rocksdb 방법 중 하나 택해서 할 수 있음)"
    
        echo "----"
    
        echo "run rocksdb" 
        echo "방법1: sudo docker container exec ${CONTAINER_NAME} ./bin/ycsb.sh run rocksdb -s -P exp_workload -p rocksdb.dir=/mnt/data/ (--> 수행 전 후에 log 뽑아야하니까 본 방법으로 수행)"
        echo "방법2: run 할 수 있는 shell script 정의해서 dockerFile 에서 해당 script 옮기고 스크립트로 수행하기:: sudo docker container exec ${CONTAINER_NAME} ./run_ycsb"
        echo "방법3: container attach 해서 들어가서 돌리기: sudo docker container attach ${CONTAINER_NAME}  로 attach "
}

echo "Check workload file before run!!! (script will start in 5 sec)"

sleep 5

echo $CWD

if [ ! -z $ROCKSDB_DIR ]
then
	cd $ROCKSDB_DIR
	make rocksdbjavastaticrelease -j8
	cp java/target/rocksdbjni-5.16.6.jar $CWD
fi

cd $CWD

# make image
sudo docker build --tag ${IMAGE_TAG} .

# delete container if it is already exist 
sudo docker container rm -f ${CONTAINER_NAME}

# run docker container
sudo docker container run -d -it -v ${DATA_DIR}:/mnt/data/ --name ${CONTAINER_NAME} ${IMAGE_TAG}

print_usage
