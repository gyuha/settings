# Docker settings
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
	user: db_user,
	pwd: your_super_secure_password,
	roles: [ { role: userAdminAnyDatabase, db: admin } ]
}
)
```

추가 후 2, 3을 실행하면 됨.
여기 역시도 설치하면 시스템 시작시 자동 시작을 해 준다.

### 2. Mongo stop & remove
1에서 설치한 몽고db를 중단하고 지워 준다.

### 3. Run with auth
인증을 포함해서 몽고DB를 실행하고 시작시 자동으로 시작하기 해 준다.

### 참고
 * [Securing a Containerized Instance of MongoDB](https://rancher.com/securing-containerized-instance-mongodb/)
