#!/bin/bash
URL=http://google.com
OUTPUT=/tmp/site.txt
STDOUT=0

function usage()
{
	echo "
Site read time check

Usage: `basename $0` [-h] [-all] [-o out] [-l level] file1 file2 ...

-u : Site url
-o : Output file. using -o followed by its name. If no output file is
	 /tmp/site.txt
-v : verbose
"
}

# check for empty search
if [[ "" = "$@" ]]; then
	echo "(no search term. \``basename $0` -h\` for usage)"
	exit 1
fi

# read the options
while [[ "$1" == -* ]]; do
    case $1 in
        -h)
            usage;
            exit;
            ;;
        -u)
            shift
			URL=$1
            ;;
        -o)
            shift
            OUTPUT=$1
            ;;
		-v)
			shift
			STDOUT=1
			;;
    esac
    shift
done

NOW=$(date +"%Y-%m-%d %H:%M:%S")
START=$(date +%s%N)
lynx -source $URL 1>/dev/null
END=$(date +%s%N)
DIFF=$(($END - $START))
MSG="$NOW\t$URL\t$(echo "scale=3;($END - $START)/(1*10^09)" | bc) seconds"
echo -e $MSG >>$OUTPUT
if [ $STDOUT -eq 1 ]
then
	echo -e $MSG
fi
