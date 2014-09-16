#!/bin/bash
#
# My first shell script
#	True 0   False 1
#

#clear
#echo "Knowledge is Power"


#zenity --question --text="knowledge is power"

#zenity --warning --text "This will kill, are you sure?";
#echo $?

#list 例子
:<<!
zenity --list \
  --title="Choose the Bugs You Wish to View" \
  --column="Bug Number" --column="Severity" --column="Description" \
    992383 Normal "GtkTreeView crashes on multiple selections" \
    293823 High "GNOME Dictionary does not handle proxy" \
    393823 Critical "Menu editing does not work in GNOME 2.0"
!

#多选
#hello=$(zenity --list --checklist --title "Testing checkbox." --text "Checkbox test." --column "" --column "Nice" False 1st False 2nd False 3rd #False 4th False 5th)
#echo $hello

#单选
: <<'end_long_comment'
hello=$(
		zenity 	--list \
			--radiolist \
			--title "Testing checkbox." \
			--text "Checkbox test." \
			--column "" --column "Nice" \
			False 1st \
			False 2nd \
			False $PROXY_MODE_NONE False 4th False 5th)
echo $hello
end_long_comment

: <<'end_long_comment'
tt(){
	echo "ttsss" $1
}
tt 2
end_long_comment


: <<'end_long_comment'
a=10
b=10

if [ $a==$b ]
then
	echo "a==b"
else 
	echo "a!=b"
fi
end_long_comment

: <<'end_long_comment'
aaa=aaa;

ttest(){

	echo "ttest()  $cur_mode  $PROXY_MODE_MANUAL"	;


	if [[ $cur_mode == *$1* ]]
	then
		echo "weichen相等"
	else 
		echo "weichen不等"
	fi	
}
ttest $PROXY_MODE_MANUAL;
end_long_comment


: <<'end_long_comment'
a=10
b=10

test(){
	echo true $1;
}
echo "????="$(test dd);
end_long_comment






#gsettings set org.gnome.system.proxy mode 'manual'
#gsettings set org.gnome.system.proxy mode 'none'
#gsettings set org.gnome.system.proxy mode 'auto'
#gsettings get org.gnome.system.proxy mode

# http https ftp socks
#gsettings get org.gnome.system.proxy.http host
#gsettings get org.gnome.system.proxy.http port




#自定义模式
PROXY_MODE_NONE='none';
PROXY_MODE_MANUAL='manual';
PROXY_MODE_MANUAL_GAE=manual_goagent_8087;
PROXY_MODE_MANUAL_FREEGATE_8580=manual_freegate_8580;
PROXY_MODE_MANUAL_FREEGATE_8581=manual_freegate_8581;

PROXY_HOST='127.0.0.1'

PROXY_PORT_8087=8087;
PROXY_PORT_8580=8580;
PROXY_PORT_8581=8581;



#TODO PROXY_MODE_AUTO=auto;	

#当前模式
cur_mode=-1;
#当前端口
cur_port=-1;
cur_host=-1;

# 判断打开模式和端口
judge_mode_port(){
	#echo "judge_mode $cur_mode  $1   $2 \n"
	if [[ $cur_mode == *$1* && $cur_mode == *$PROXY_MODE_NONE* ]]
	then
		echo true;
	elif [[ $cur_mode == *$1* && $cur_mode == *$PROXY_MODE_MANUAL* ]]
	then
		if [ $cur_port == $2 ]
		then
			echo true;
		else
			echo false;
		fi 
	else 
		echo false;
	fi	
}


#设置代理
set_proxy(){

	zenity --info --text="$cur_mode,$cur_host:$cur_port"	
	gsettings set org.gnome.system.proxy mode $cur_mode
	gsettings set org.gnome.system.proxy.http host $cur_host
	gsettings set org.gnome.system.proxy.http port $cur_port
	gsettings set org.gnome.system.proxy.https host $cur_host
	gsettings set org.gnome.system.proxy.https port $cur_port
	gsettings set org.gnome.system.proxy.ftp host $cur_host
	gsettings set org.gnome.system.proxy.ftp port $cur_port
	gsettings set org.gnome.system.proxy.socks host $cur_host
	gsettings set org.gnome.system.proxy.socks port $cur_port
}



#获取当前系统proxy mode 和 port
cur_mode=$(gsettings get org.gnome.system.proxy mode)
cur_host=$(gsettings get org.gnome.system.proxy.http host)
cur_port=$(gsettings get org.gnome.system.proxy.http port)

echo 'cur_mode='$cur_mode     ${#cur_mode}  'cur_port='$cur_port

#judge_mode_port $PROXY_MODE_NONE
#judge_mode_port $PROXY_MODE_MANUAL $PROXY_PORT_8580

#单选 --width=500 --height=200  $(judge_mode $PROXY_MODE_MANUAL)

select=$(	zenity 	--list --width=500 --height=230\
			--radiolist \
			--title "Testing checkbox." \
			--text "cur: [mode=$cur_mode]  [proxy=$cur_host:$cur_port]" \
			--column "----  select  ----" --column "Name" \
			$(judge_mode_port $PROXY_MODE_NONE) $PROXY_MODE_NONE \
			$(judge_mode_port $PROXY_MODE_MANUAL $PROXY_PORT_8087) $PROXY_MODE_MANUAL_GAE \
			$(judge_mode_port $PROXY_MODE_MANUAL $PROXY_PORT_8580) $PROXY_MODE_MANUAL_FREEGATE_8580 \
			$(judge_mode_port $PROXY_MODE_MANUAL $PROXY_PORT_8581) $PROXY_MODE_MANUAL_FREEGATE_8581 \
			)
echo $select

if [[ $select == $PROXY_MODE_NONE ]]; then
	cur_mode=$PROXY_MODE_NONE;
	set_proxy;
	#gsettings set org.gnome.system.proxy mode 'none'
elif [[ $select == $PROXY_MODE_MANUAL_GAE ]]; then
	cur_mode=$PROXY_MODE_MANUAL;
	cur_host=$PROXY_HOST;
	cur_port=$PROXY_PORT_8087;
	set_proxy;
	#gsettings set org.gnome.system.proxy mode 'manual'
elif [[ $select == $PROXY_MODE_MANUAL_FREEGATE_8580 ]]; then
	cur_mode=$PROXY_MODE_MANUAL;
	cur_host=$PROXY_HOST;
	cur_port=$PROXY_PORT_8580;
	set_proxy;
	#gsettings set org.gnome.system.proxy mode 'manual'
elif [[ $select == $PROXY_MODE_MANUAL_FREEGATE_8581 ]]; then
	cur_mode=$PROXY_MODE_MANUAL;
	cur_host=$PROXY_HOST;
	cur_port=$PROXY_PORT_8581;
	set_proxy;
	#gsettings set org.gnome.system.proxy mode 'manual'
else
	echo "game over"	
fi


: <<'end_long_comment'
end_long_comment
