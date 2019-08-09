# MTU 값을 변경해서 우회 접속하기
# 여기서는 이더넷 어뎁터 중에서 제일 마지막을 찾아서 mtu를 바꿔 준다.
# 상황에 따라서 다른 이더넷 어뎁터를 바꿔 줘야 할 수도 있다.
MTU=400
# 파라미터가 1개 인지 체크
if [ "$#" -eq  "1" ]
then
	MTU=$1
fi

# 숫자 인지 체크
re='^[0-9]+$'
if ! [[ $MTU =~ $re ]] ; then
   echo "error: Not a number" >&2; exit 1
fi

ETH=`ifconfig | grep mtu | tail -1 | awk '{print $1}' | sed "s/://"`
echo "Network adapter name : $ETH"
echo "To MTU : $MTU"

sudo ifconfig $ETH mtu $MTU
sudo ifconfig

echo "Complete..."
