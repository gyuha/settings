# Docker settings

## Mariadb

### 설치

```bash
$ sudo ./mariadb.sh
input Mariadb Password :
```

### 접속 테스트

```bash
$ yarn
$ node mariadb.js
root Password :
```
```

## PostgreSQL

### 설치

```bash
$ sudo ./postgres.sh
input PostgreSQL Password :
```

### 접속 테스트

```bash
$ yarn
$ node postgres.js
root Password :
```


## Mongodb
### 실행
> ./install_mongodb.sh

### 1. Install basic
기본적인 몽고 db를 설치 한다. 기본적으로 실행은 되지만 인증이 빠져 있음.

설치 후 나오는 메시지 대로 진행을 하면 인증된 사용자를 추가 할 수 있다.

docker의 이미지의 bash에 접근 한다.
> docker exec -it mongodb bash

몽고db를 실행 한다.
> mongo

몽고 db에서 admin db로 접근한다.
> use admin

몽고 아래와 같이 입력해서 데이터를 넣을 준다.
```json
db.createUser(
{
	user: "db_user",
	pwd: "your_super_secure_password",
	roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
}
)
```

추가 후 2, 3을 실행하면 됨.
여기 역시도 설치하면 시스템 시작시 자동 시작을 해 준다.

auth 적용 후 로그인 하는 방법
> mongo -u admin -p [password] --authenticationDatabase admin

### 2. Mongo stop & remove
1에서 설치한 몽고db를 중단하고 지워 준다.

### 3. Run with auth
인증을 포함해서 몽고DB를 실행하고 시작시 자동으로 시작하기 해 준다.


## Docker 이미지들을 자동으로 시작하기

docker가 등록이 되어 있지만.. 한번 건드려 줘야 이미지 들이 시작 해서..
서비스에서 시스템이 시작 하면서 한번 건드려 준다.

> sudo ./docker_service.sh



### 참고
 * [Securing a Containerized Instance of MongoDB](https://rancher.com/securing-containerized-instance-mongodb/)
 * [Enable mongodb authentication with docker](https://medium.com/@itseranga/enable-mongodb-authentication-with-docker-1b9f7d405a94)
 * [Docker로 개발용 DB 만들기](https://gongzza.github.io/docker/db-sample/)
