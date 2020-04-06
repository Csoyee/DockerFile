# base image
FROM ubuntu  

WORKDIR /app/

# update apt package
RUN apt-get update && apt-get install -y \
	openjdk-8-jdk \
	maven \
	python \
	git   

# download YCSB source code
RUN git clone https://github.com/brianfrankcooper/YCSB

# compile YCSB
WORKDIR /app/YCSB

RUN mvn -pl site.ycsb:rocksdb-binding -am clean package   

