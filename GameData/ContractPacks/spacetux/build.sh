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
#
#if [ "$os" != "cygwin" ]; then
#	root=$HOME
#else
#	root="\\\\~"
#	root=$HOME
#fi
root=/d/Users/jbb

gasbodies="Jool"
bodies="Minmus Moho Eve Gilly Duna Ike   Dres Jool Laythe  Tylo Vall Bop Pol   Eeloo"
deadlines=(106  300  450  475  700  730  1300  2600  2600  2600 2600 2600 2600 3900)

template=cfg.template
rtgiga=remotetech.giga.template
rtantenna=remotetech.antenna.template
rt=remotetech.template

arantenna=antennarange.antenna.template
ar=antennarange.template

MinmusRemoteTech="mediumDishAntenna"
MohoRemoteTech="commDish"
DresRemoteTech="RTLongDish2"
DunaRemoteTech="commDish"
EveRemoteTech="commDish"
GillyRemoteTech="commDish"
IkeRemoteTech="commDish"

JoolRemoteTech="AnyGigaDish"
EelooRemoteTech="AnyGigaDish"
LaytheRemoteTech="AnyGigaDish"
TyloRemoteTech="AnyGigaDish"
VallRemoteTech="AnyGigaDish"
BopRemoteTech="AnyGigaDish"
PolRemoteTech="AnyGigaDish"


MinmusAntennaRange="mediumDishAntenna"
MohoAntennaRange="commDish"
DresAntennaRange="commDish"
DunaAntennaRange="commDish"
EveAntennaRange="commDish"
GillyAntennaRange="commDish"
IkeAntennaRange="commDish"

JoolAntennaRange="commDish"
EelooAntennaRange="commDish"
LaytheAntennaRange="commDish"
TyloAntennaRange="commDish"
VallAntennaRange="commDish"
BopAntennaRange="commDish"
PolAntennaRange="commDish"

files=""
#cnt=570
#bodycnt=-1
#for i in $bodies; do
#for i in 1; do
#	bodycnt=$((bodycnt+1))
	fname=${i}_unmanned.tmp
	fname2=${i}_unmanned2.tmp
	fnameFinal=UnmannedContracts.cfg
	rm -f $fname $fnameFinal

	files="$files $fnameFinal"
	if [ "$1" = "clean" ]; then
		rm -f $fnameFinal
		rm -f Makefile
		#continue
	else
		cp $template $fname
		echo $template $fname
#		#deadline=${deadlines[$bodycnt]}

		deadline=10000

		if [ "$os" = "osx" ]; then
			sed  -i "" "s/<PLANETARYBODY>/${i}/g" $fname
			sed  -i "" "s/<DEADLINE>/$deadline/g" $fname
		else
			sed  -i "s/<PLANETARYBODY>/${i}/g" $fname
			sed  -i "s/<DEADLINE>/$deadline/g" $fname

		fi

		cp $fname $fnameFinal
		if [ "$os" = "osx" ]; then
			sed -i "" "s/<REMOTETECH>//g" $fnameFinal
			sed -i "" "s/<ANTENNARANGE>//g" $fnameFinal
		else
			sed -i "s/<REMOTETECH>//g" $fnameFinal
			sed -i "s/<ANTENNARANGE>//g" $fnameFinal
		 fi
		
#		cnt=$((cnt+1))
#		for n in `seq 1 6`; do
#			s="<NUM_${n}>"
#			if [ "$os" = "osx" ]; then
#				sed -i "" "s/${s}/${cnt}${n}/g" $fname
#			else
#				sed -i "s/${s}/${cnt}${n}/g" $fname
#			fi
#		done

#		oIFS=$IFS
#		IFS=
#		while IFS=$'\n' read -r var ; do
#			if [[ "$var" =~ "<REMOTETECH>" ]]; then
#				v="${i}RemoteTech"
##echo "v: $v"
##echo "v = ${!v}"
#				if [ "${!v}" == "AnyGigaDish" ]; then
#					cat $rtgiga >>$fname2
#				else
#					sed "s/<ANTENNARANGE>/${!v}/g" <$rtantenna >>$fname2
#				fi
#				cat $rt >>$fname2	
#			else
#				echo $var >>$fname2
#			fi
#		done <$fname
		

#		while IFS=$'\n' read -r var ; do
#			if [[ "$var" =~ "<ANTENNARANGE>" ]]; then
#				v="${i}AntennaRange"
##echo "v1: $v"
##echo "v1= ${!v}"
#				sed "s/<ANTENNA>/${!v}/g" <$arantenna >>$fnameFinal
#				cat $ar >>$fnameFinal	
#			else
#				echo $var >>$fnameFinal
#			fi
#		done <$fname2
#		
#		
#		IFS=$oIFS
#		rm $fname $fname2
		rm -f $fname
	fi
#done

if [ "$1" != "clean" ]; then
#	for i in $gasbodies; do
#		echo "Gas body: $i"
#		fname=${i}_unmanned.cfg
#		if [ "$os" = "osx" ]; then
#			sed -i "" '/<LANDING_FOLLOWS>/q' $fname
#		else
#			sed -i '/<LANDING_FOLLOWS>/q' $fname
#		fi
#	done

echo $root

	sed "s/<PLANETARYBODIES>/$files/g" <Makefile.template >Makefile
	if [ "$os" = "osx" ]; then
		sed -i "" "s|<ROOT>|${root}|g" Makefile
	else
		sed -i "s|<ROOT>|${root}|g" Makefile
	fi
else
	cat >Makefile <<_EOF_
build:
	./build.sh
_EOF_
fi
