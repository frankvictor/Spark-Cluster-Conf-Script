#!/bin/bash

#test if file exist
if [ -f ~/.ssh/id_rsa.pub ]; then
	if [ "$#" == "0" ]; then
		echo "usage $0 [m/s]"
		echo "m: add multiple node"
		echo "s: add single node"
		exit 1
	fi

	case $1 in
		"m")
			echo -n "please enter ip prefix: [user@]xxx.xxx.xxx. > "
			read prefix
			echo -n "start > "
			read startd
			echo -n "end > "
			read end

			while [ $startd -le $end ]
			do
				sshpubkey=`cat ~/.ssh/id_rsa.pub`
				ssh "$prefix$startd" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && \
					echo $sshpubkey >> ~/.ssh/authorized_keys && \
					chmod 644 ~/.ssh/authorized_keys"
				((startd++))
			done
			;;
		"s")
			;;
	esac
else
	echo "file ~/.ssh/id_rsa.pub does not exist!"
	echo "generate ssh key"
	cd ~/.ssh/ && ssh-keygen
	echo "please try again"
	exit 1
fi
