#!/bin/bash

#update: 
#  1.now can install arbitrary version
#  2.now can install in arbitrary path

if [ "$#" -ne "2" ]; then
	echo "usage $0 jdk_file-path install_path(do not need end with /)"
	echo "need to use other method to add java to PATH"
	echo "can install jdk on remote machines"
	echo "file type can be: bin or tar.gz"
	echo "example: $0 ./jdk-6u31-linux-x64.bin soft(can not be ~/soft)"
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

			while [ $startd -le $end ]
			do
				ssh $prefix$startd mkdir -p $2
				scp $1 $prefix$startd:~/$2
				if [ ${jdk_file_name##*.} == "bin" ]; then
					ssh $prefix$startd "cd $2 && chmod +x ./$jdk_file_name && ./$jdk_file_name && rm $jdk_file_name"
				else
					ssh $prefix$startd "cd $2 && tar zxf ./$jdk_file_name && rm $jdk_file_name"
				fi
				((startd++))

			done
else
	echo "file $1 does not exist!"
	exit 1
fi
