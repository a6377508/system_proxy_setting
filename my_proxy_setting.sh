#!/bin/bash

#定义变量
#自定义模式
PROXY_MODE_NONE='none';
PROXY_MODE_MANUAL='manual';
PROXY_MODE_AUTO='auto';
PROXY_MODE_MANUAL_GAE=manual_goagent_8087;
PROXY_MODE_MANUAL_FREEGATE_8580=manual_freegate_8580;
PROXY_MODE_MANUAL_FREEGATE_8581=manual_freegate_8581;

PROXY_HOST='127.0.0.1'

PROXY_PORT_8087=8087;
PROXY_PORT_8580=8580;
PROXY_PORT_8581=8581;

#当前模式
cur_mode=-1;
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
	echo "i love this game. "	
fi


: <<'end_long_comment'
end_long_comment
