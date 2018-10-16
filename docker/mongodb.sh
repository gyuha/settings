#!/bin/bash
# 참고
# - https://medium.com/@itseranga/enable-mongodb-authentication-with-docker-1b9f7d405a94
# - https://www.mkyong.com/mongodb/mongodb-authentication-example/
# CLI login
#  > mongo -u admin -p [password] --authenticationDatabase admin
#if [ $UID -ne 0 ]; then
	#echo Non root user. Please run as root.
	#exit 1;
#fi

PS_NAME=mongodb
VOLUME_NAME=mongodb.data

function usage()
{
	echo "Install MongoDB by docker
Usage: `basename $0` [-h]
	-h : help"
}

case "$1" in
	"-h")
		usage;
		exit 0;
		;;
esac

echo "MondoDB Install Step "
echo "  1. Install basic"
echo "  2. Mongodb stop & remove"
echo "  3. Run with auth"
echo "  4. Monodb volume remove"
echo -n "Select type : "
read select_menu
echo


# 기본 mongodb 만들기
function createVolume()
{
	dbexist=$(docker volume ls|awk '{print $2}'|grep mongodb.data)
	if [ ! -n "$dbexist" ]; then
		echo "Create mongodb voume"
		docker volume create $VOLUME_NAME
	fi
}

function runWithoutAuth()
{
	echo -n "Input MongoDB Password : "
	read -s password
	echo

	createVolume;

	# docker run -p 27017:27017 --restart=always --name $PS_NAME -d -v $VOLUME_NAME:/data/db mongo:latest
	docker run -p 27017:27017 --name $PS_NAME -d -v $VOLUME_NAME:/data/db mongo:latest
	echo
	echo "#  To do this, first log into the MongoDB container with:"
	echo "> docker exec -it $PS_NAME bash"
	echo "> mongo"
	echo
	echo "# Now, enter this stanza of code and press Enter:"
	echo "> use admin
db.createUser(
{
	user: \"admin\",
	pwd: \"$password\",
	roles: [ { role: \"userAdminAnyDatabase\", db: \"admin\" } ]
}
)"
	echo
	echo "# Show added users"
	echo "> show users"
}

# 기존 docker를 중단하고 지움.
function stopAndRemoveDocker()
{
	echo "Stop mongodb docker"
	docker stop $PS_NAME
	echo "Remove mongodb docker"
	docker rm $PS_NAME
}

# 인증을 포함한 시작 만들기
function runWithAuth()
{
#	createVolume;
	echo "Docker run with auth"
	docker run -p 27017:27017 \
		--restart=always \
		--name $PS_NAME -d \
		-v $VOLUME_NAME:/data/db \
		mongo:latest --auth

}

# mongodb용 volume 지우기
function removeVolume()
{
	dbexist=$(docker volume ls|awk '{print $2}'|grep mongodb.data)
	if [ -n "$dbexist" ]; then
		echo "Remove mongodb volume"
		docker volume rm $VOLUME_NAME
	fi
}


if [ $select_menu -eq "1" ]; then
	runWithoutAuth;
elif [ $select_menu -eq "2" ]; then
	stopAndRemoveDocker;
elif [ $select_menu -eq "3" ]; then
	runWithAuth;
elif [ $select_menu -eq "4" ]; then
	removeVolume;
fi
