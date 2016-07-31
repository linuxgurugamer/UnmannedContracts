#!/bin/bash

#if [[ "$OSTYPE" == "linux-gnu" ]]; then
#	os=linux
#elif [[ "$OSTYPE" == "darwin"* ]]; then
#	os=osx
#elif [[ "$OSTYPE" == "cygwin" ]]; then
#        # POSIX compatibility layer and Linux environment emulation for Windows
#		os=cygwin
#	else
#		exit
#fi

echo -e "\n\n"
#if [ "$os" != "cygwin" ]; then
#	root=$HOME
#else
	root="/d/Users/jbb"
#fi
releasedir=${root}/release
installdir=${root}/install
mkdir -p $releasedir


cat UnmannedContracts.version
echo -e "\nEnter version: "
read version
echo -e "\n\nOK to proceed (Y/n): "
read yn
[ "$yn" = 'n' -o "$yn" = "N" ] && exit
curdir=`pwd`
i=`awk -v a="$curdir" -v b="GameData" 'BEGIN{print index(a,b)}'`
i=$((i-1))
curdir=`echo $curdir | cut -c1-${i}`

mod=$1
shift

[ "$1" = "version" ] && exit

basedir=`pwd`
basedir=`basename $basedir`
files=""
for i in $*; do
	files="$files GameData/ContractPacks/${basedir}/$i"
done
files="Gamedata/spacetux Gamedata/ContractPacks/Spacetux/UnmannedContracts"
cd $installdir

rm -f  ${releasedir}/${mod}-${version}.zip

echo "zip -9r ${releasedir}/${mod}-${version}.zip  $files"
zip -9r ${releasedir}/${mod}-${version}.zip  $files
