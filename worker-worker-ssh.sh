#!/bin/bash

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

		startd1=$startd
		while [ $startd -le $end ]
		do
			ssh $prefix$startd "cd .ssh && ssh-keygen"
			ssh $prefix$startd "cd .ssh && cat id_rsa.pub" >> ./authorized_keys
			((startd++))
		done

		sshauthorized_keys=`cat ./authorized_keys`
		startd=$startd1
		while [ $startd -le $end ]
		do
			ssh $prefix$startd "echo \"$sshauthorized_keys\" >> ~/.ssh/authorized_keys"
			((startd++))
		done
		;;
	"s")
		;;
esac
