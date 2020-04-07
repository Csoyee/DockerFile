# YCSB docker file

- Customized 된 락스디비 이미지를 돌릴 수 있다. 새로 rocksdb 를 컴파일 할 경우run\_rocksdb.sh 수행 시 4 번째 인자로 rocksdb path 를 전달해야 한다.

- 만일 reset\_customized.sh, rocksdbjni, workload 파일이 없으면 이미지 생성 시 에러가 발생한다. customized version 을 쓰고 싶지 않다면 Non Customized 버전 디렉토리 참조


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

## TODO
- data directory mount 코드 추가
- load, run command define 하기 
