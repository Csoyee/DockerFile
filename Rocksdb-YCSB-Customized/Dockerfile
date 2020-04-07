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

# run customized rocksdb, 
# assume that there is prebuilded jni file rocksdbjni-5.16.6.jar
ADD rocksdbjni-5.16.6.jar /app/YCSB/rocksdbjni-5.16.6.jar
ADD reset_customize.sh /app/YCSB/reset_customize.sh
ADD pom.xml /app/YCSB/rocksdb/pom.xml

# if file not exist run original one 
RUN if [ -f reset_customize.sh ] && [ -f rocksdbjni-5.16.6.jar ] ; then chmod +x reset_customize.sh ; ./reset_customize.sh ; fi

# pass customed workload
ADD exp_workload /app/YCSB/exp_workload
