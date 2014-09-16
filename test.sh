


./my_proxy_setting.sh


: <<'end_long_comment'

x=1
hello=$x
echo $hello

tt(){
	echo "ttsss $1=" $1
	zenity --info --text=$1
}
tt 2




if [[ $cur_mode == *${1}* ]]
	then	
		echo "weichen ==  show: $cur_mode  ${1}"
	else 
		echo "weichen !="
	fi


	if [[ $cur_mode == *${PROXY_MODE_NONE}* ]]
	then	
		echo "~~weichen =="
	else 
		echo "~~weichen !="
	fi


PROXY_MODE_MANUAL='manual';
PROXY_MODE_NONE='none';
if [[ $(gsettings get org.gnome.system.proxy mode) == *${PROXY_MODE_NONE}* ]]
then
	echo "相等"
else
	echo "不等"
fi



a=10;
b=12;
if [ $a == $b ]
then	
	echo "ss相等"
else 
	echo "ss不相等"
fi




echo ${#PROXY_MODE_MANUAL}

echo '$PROXY_MODE_MANUAL'

t="aaa";
tt="aa";

if [[ "$t" == *${tt}* ]]
then
	echo "相等"
else
	echo "不等"
fi


S="Pineapple"
 
if [ "${S}" == *apple* ]; then
    echo "Yes"
else
    echo "No"
fi



S="Pineapple"
SS="apple"
if [[ "${S}" == *${SS}* ]]; then
    echo "Yes"
else
    echo "No"
fi
end_long_comment




