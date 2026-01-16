#!/bin/bash

# 색상 정의
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# uv 설치 함수
install_uv() {
    echo -e "${YELLOW}uv가 설치되어 있지 않습니다. 설치를 시작합니다...${NC}"

    # uv 공식 설치 스크립트
    curl -LsSf https://astral.sh/uv/install.sh | sh

    echo -e "${GREEN}uv 설치가 완료되었습니다.${NC}"
    echo -e "${YELLOW}쉘 설정을 다시 읽으려면 다음 명령을 실행하세요:${NC}"
    echo ". ~/.bashrc  # 또는 . ~/.zshrc (zsh 사용 시)"
    exit 0
}

# 최신 Python 설치 함수
install_latest_python() {
    echo -e "${YELLOW}최신 Python 버전 설치를 시작합니다...${NC}"

    # 가장 최신 안정 버전의 Python 설치
    uv python install 3.14

    echo -e "${GREEN}Python 3.14 설치가 완료되었습니다.${NC}"

    # Python 버전 확인
    uv python list
    uv python pin 3.14
}

setup_python_symlink() {
    echo -e "${YELLOW}python 명령어 설정 중...${NC}"

    local python_path=$(uv python find 3.14 2>/dev/null)

    if [ -z "$python_path" ]; then
        echo -e "${RED}Python 3.14 경로를 찾을 수 없습니다.${NC}"
        return 1
    fi

    mkdir -p ~/.local/bin
    rm -f ~/.local/bin/python ~/.local/bin/python3

    ln -sf "$python_path" ~/.local/bin/python
    ln -sf "$python_path" ~/.local/bin/python3

    echo -e "${GREEN}심볼릭 링크가 생성되었습니다:${NC}"
    echo "  ~/.local/bin/python -> $python_path"
    echo "  ~/.local/bin/python3 -> $python_path"

    if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
        echo -e "${YELLOW}~/.local/bin이 PATH에 없습니다. 다음을 쉘 설정 파일에 추가하세요:${NC}"
        echo 'export PATH="$HOME/.local/bin:$PATH"'
    fi
}

# 메인 스크립트 로직
main() {
    # uv 존재 여부 확인
    if ! command -v uv &> /dev/null; then
        install_uv
    fi

    install_latest_python
    setup_python_symlink

    echo -e "${GREEN}모든 작업이 성공적으로 완료되었습니다.${NC}"
}

# 스크립트 실행
main
