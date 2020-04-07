# YCSB docker file

## Build Docker Image 

```bash
$ sudo docker build --tag csoyee/ycsb:1.0 .
```

## Run Image As as Container

- 현재는 command 를 define 해두지 않아서 직접 들어가서 YCSB 벤치마크를 수행할 수 있다.

#### test: 
```bash
$ sudo docker run -it --name ycsb csoyee/ycsb:1.0
# ./bin/ycsb load rocksdb -s -P workloads/workloada -p rocksdb.dir=/data/
```

## Automated Script

```bash
$ ./run_rocksdb [IMAGE TAG] [CONTAINER NAME] [DATA DIR]
```
