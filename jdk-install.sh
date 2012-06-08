#!/bin/bash

if [ "$#" -ne "1" ]; then
	echo "usage $0 jdk-path "
	echo "must use version: jdk-6u31-linux-x64.bin"
	exit 1
fi

#test if jdkfile exist
if [ -f $1 ]; then
			echo -n "please enter ip prefix: [user@]xxx.xxx.xxx. > "
			read prefix
			echo -n "start > "
			read startd
			echo -n "end > "
			read end

			while [ $startd -le $end ]
			do
				ssh $prefix$startd mkdir -p jdk 
				scp $1 $prefix$startd:~/jdk 
				ssh $prefix$startd "cd jdk && ./jdk-6u31-linux-x64.bin"
				((startd++))
			done
else
	echo "file $1 does not exist!"
	exit 1
fi
