# MTU 값을 변경해서 우회 접속하기
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
