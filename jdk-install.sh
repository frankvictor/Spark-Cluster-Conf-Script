#!/bin/bash

#update: 
#  1.now can install arbitrary version
#  2.now can install in arbitrary path

if [ "$#" -ne "1" ]; then
	echo "usage $0 jdk_file-path install_path"
	echo "can install jdk on remote machines"
	echo "example: $0 ./jdk-6u31-linux-x64.bin soft/(can not be ~/soft)"
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

			jdk_file_name=`basename $1`
			echo "jdk_file_name: $jdk_file_name"

			while [ $startd -le $end ]
			do
				ssh $prefix$startd mkdir -p $2 
				scp $1 $prefix$startd:~/$2
				ssh $prefix$startd "cd $2 && ./$jdk_file_name && rm $jdk_file_name
				((startd++))
			done
else
	echo "file $1 does not exist!"
	exit 1
fi
