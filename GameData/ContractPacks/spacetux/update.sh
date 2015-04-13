#!/bin/bash

echo -e "\n\n"

releasedir=~/release
installdir=~/install
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

[ "$1" = "version" ] && exit

basedir=`pwd`
basedir=`basename $basedir`
files=""
for i in $*; do
	files="$files GameData/ContractPacks/${basedir}/$i"
done
files="Gamedata/ContractPacks/Spacetux/SharedAssets Gamedata/ContractPacks/Spacetux/UnmannedContracts"
cd $installdir

echo "zip -9r ${releasedir}/${mod}-${major}.${minor}.${patch}.zip  $files"
zip -9r ${releasedir}/${mod}-${major}.${minor}.${patch}.zip  $files
