#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	os=linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
	os=osx
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
		os=cygwin
	else
		exit
fi

if [ "$os" != "cygwin" ]; then
	root=$HOME
else
	root="\\\\~"
fi

gasbodies="Jool"
bodies="Minmus Moho Eve Gilly Duna Ike Dres Laythe Tylo Vall Bop Eeloo Pol $gasbodies"

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
cnt=570
for i in $bodies; do
	fname=${i}_unmanned.tmp
	fname2=${i}_unmanned2.tmp
	fnameFinal=${i}_unmanned.cfg
	rm -f $fname $fnameFinal

	files="$files $fnameFinal"
	if [ "$1" = "clean" ]; then
		rm -f $fnameFinal
		rm -f Makefile
		continue
	else
		cp $template $fname
echo $template $fname
		if [ "$os" = "osx" ]; then
			sed  -i "" "s/<PLANETARYBODY>/${i}/g" $fname
		else
			sed  -i "s/<PLANETARYBODY>/${i}/g" $fname
		fi
		cnt=$((cnt+1))
		for n in `seq 1 6`; do
			s="<NUM_${n}>"
			if [ "$os" = "osx" ]; then
				sed -i "" "s/${s}/${cnt}${n}/g" $fname
			else
				sed -i "s/${s}/${cnt}${n}/g" $fname
			fi
		done

		oIFS=$IFS
		IFS=
		while IFS=$'\n' read -r var ; do
			if [[ "$var" =~ "<REMOTETECH>" ]]; then
				v="${i}RemoteTech"
#echo "v: $v"
#echo "v = ${!v}"
				if [ "${!v}" == "AnyGigaDish" ]; then
					cat $rtgiga >>$fname2
				else
					sed "s/<ANTENNA>/${!v}/g" <$rtantenna >>$fname2
				fi
				cat $rt >>$fname2	
			else
				echo $var >>$fname2
			fi
		done <$fname
		

		while IFS=$'\n' read -r var ; do
			if [[ "$var" =~ "<ANTENNARANGE>" ]]; then
				v="${i}AntennaRange"
#echo "v1: $v"
#echo "v1= ${!v}"
				sed "s/<ANTENNA>/${!v}/g" <$arantenna >>$fnameFinal
				cat $ar >>$fnameFinal	
			else
				echo $var >>$fnameFinal
			fi
		done <$fname2
		
		
		IFS=$oIFS
		rm $fname $fname2
	fi
done

if [ "$1" != "clean" ]; then
	for i in $gasbodies; do
		echo "Gas body: $i"
		fname=${i}_unmanned.cfg
		if [ "$os" = "osx" ]; then
			sed -i "" '/<LANDING_FOLLOWS>/q' $fname
		else
			sed -i '/<LANDING_FOLLOWS>/q' $fname
		fi
	done

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
