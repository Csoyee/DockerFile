

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


echo $CWD

if [ ! -z $ROCKSDB_DIR ]
then
	cd $ROCKSDB_DIR
	#make rocksdbjavastaticrelease -j8
	cp java/target/rocksdbjni-5.16.6.jar $CWD
fi

cd $CWD

# make image
sudo docker build --tag ${IMAGE_TAG} .

# delete container if it is already exist 
sudo docker container rm -f ${CONTAINER_NAME}

# run docker container
sudo docker container run -d -it -v ${DATA_DIR}:/mnt/data/ --name ${CONTAINER_NAME} ${IMAGE_TAG}
