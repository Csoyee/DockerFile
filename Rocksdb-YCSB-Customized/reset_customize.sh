#!/bin/bash 

mvn -pl site.ycsb:rocksdb-binding -am clean package

rm ./rocksdb/target/dependency/rocksdbjni-*

cp rocksdbjni-5.16.6.jar ./rocksdb/target/dependency/.
