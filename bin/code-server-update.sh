#!/bin/bash

curl -fsSL https://code-server.dev/install.sh | sh

# 폰트 업데이트
# /usr/lib/vscode/out/vs/code/browser/workbench/workbench.html
#
# 파일에 아래 내용을 추가 해 줘야 함.
#  <link rel="stylesheet" href="/fonts/fonts.css">
