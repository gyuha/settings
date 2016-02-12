RUN=false;
for (( i=1;$i<=$#;i=$i+1 ))
do
	function_exists ${!i} && eval ${!i} && RUN=true || msg "${!i} Can't find function..";
done
if $RUN eq true
then
	run_all;
fi
