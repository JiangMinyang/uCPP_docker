#!/bin/bash
function create {
	workspace="${PWD}/workspace"
	if [ ! -z "${1}" ]; then
		workspace="${1}";
	fi
	RESULT=`docker ps -a | grep 'jiangminyang/ucpp' | grep 'Up' | awk '{ print $1 }'`;
	if [[ -z "${RESULT}" ]]; then
		RESULT=`docker ps -a | grep 'jiangminyang/ucpp' | grep cs343 | grep 'Exited' | awk '{ print $1 }'`;
		if [[ -z "${RESULT}" ]]; then
			echo "createing cs343 container..."
			docker create -it --name cs343 --volume "${workspace}":/workspace jiangminyang/ucpp;
		else
			echo "container already exist in exiting state..."
		fi
		echo "starting cs343 container..."
		docker start cs343;
	else
		echo "container already exist..."
	fi
	docker exec -it cs343 bash;
}

function start {
	RESULT=`docker ps -a | grep 'jiangminyang/ucpp' | grep 'Up' | awk '{ print $1 }'`;
	if [[ -z "${RESULT}" ]]; then
		RESULT=`docker ps -a | grep 'jiangminyang/ucpp' | grep cs343 | grep 'Exited' | awk '{ print $1 }'`;
		if [[ -z "${RESULT}" ]]; then
			echo createing cs343 container...
			docker create -it --name cs343 --volume ${PWD}/workspace:/workspace jiangminyang/ucpp;
		fi
		echo starting cs343 container...
		docker start cs343;
	fi
	docker exec -it cs343 bash;
}

function stop {
	RESULT=`docker ps -a | grep 'jiangminyang/ucpp' | grep 'Up' | awk '{ print $1 }'`;
	if [[ ! -z "${RESULT}" ]]; then
			docker stop cs343;
	fi
}

function remove {
	stop;
	RESULT=`docker ps -a | grep 'jiangminyang/ucpp' | grep cs343 | grep 'Exited' | awk '{ print $1 }'`;
	if [[ ! -z "${RESULT}" ]]; then
		docker rm cs343;
	fi
}

case "$1" in
	create)
		create $2
		;;
	start)
		start
		;;
	stop)
		stop
		;;
	remove)
		remove
		;;
	*)
		start
		;;
esac
