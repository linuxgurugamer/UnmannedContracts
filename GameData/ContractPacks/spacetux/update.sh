#!/bin/bash

echo -e "\n\n"

releasedir=~/release
mkdir -p $releasedir

major=0
major=`cat version-number.txt`
minor=`cat build-number.txt`
patch=`cat patch-number.txt`

curdir=`pwd`
i=`awk -v a="$curdir" -v b="GameData" 'BEGIN{print index(a,b)}'`
i=$((i-1))
curdir=`echo $curdir | cut -c1-${i}`

mod=$1
shift
if [ "$1" = "mono" ]; then
	mono ~/bin/netkan.exe  -v unmannedcontracts.netkan
	exit
fi

#d=`date +%Y%m%d-%H:%m`
#FILES="UnmannedContracts.version"
#for i in $FILES; do
#	# mv $i ${i}.$d
#	sed "s/<MAJOR>/$major/g" ${i}.template | sed "s/<MINOR>/$minor/g" | sed "s/<PATCH>/$patch/g" >$i
#done

[ "$1" = "version" ] && exit

#if [ "$1" = "nopatch" ]; then
#	shift
#else
#	patch=$((patch+ 1))
#	echo $patch>patch-number.txt
#fi

basedir=`pwd`
basedir=`basename $basedir`
files=""
for i in $*; do
	files="$files GameData/ContractPacks/${basedir}/$i"
done
cd $curdir
# COPYFILE_DISABLE=1  disables Apple tar from putting extended attributes into tar file
#COPYFILE_DISABLE=1  tar czf ${mod}-${major}.${minor}.${patch}.tar.gz  $files

echo "zip -9r ${releasedir}/${mod}-${major}.${minor}.${patch}.zip  $files"
zip -9r ${releasedir}/${mod}-${major}.${minor}.${patch}.zip  $files
