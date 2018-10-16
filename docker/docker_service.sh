#!/bin/bash
# docker가 그냥 놔두면.. 시작하면서 올라기지 않는다.
# 부팅하면 한번 읽어줘야 등록 된 모든 이미지들이 시작 됨..
if [ $UID -ne 0 ]; then
	echo Non root user. Please run as root.
	exit 1;
fi
cp ./docker_ps.service /etc/systemd/system/
systemctl enable docker_ps.service
