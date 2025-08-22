#!/bin/bash

# OS 버전 정보 출력 스크립트
# 시스템의 배포판(distribution) 정보를 확인하기 위해 
# /etc/ 디렉토리의 모든 *release 파일을 출력
# (예: /etc/os-release, /etc/lsb-release 등)

cat /etc/*release
