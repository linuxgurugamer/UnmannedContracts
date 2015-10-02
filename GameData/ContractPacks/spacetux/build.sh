#!/bin/bash


gasbodies="Jool"
bodies="Minmus Moho Eve Gilly Duna Ike Dres Laythe Tylo Vall Bop Eeloo Pol $gasbodies"

template=cfg.template
rtgiga=remotetech.giga.template
rtantenna=remotetech.antenna.template
rt=remotetech.template

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


files=""
cnt=570
for i in $bodies; do
	fname=${i}_unmanned.tmp
	fnameFinal=${i}_unmanned.cfg
	rm -f $fname $fnameFinal

	files="$files $fnameFinal"
	if [ "$1" = "clean" ]; then
		rm  $fnameFinal
		rm -f Makefile
	else
		cp $template $fname
echo $template $fname

		sed -i "s/<PLANETARYBODY>/${i}/g" $fname
		cnt=$((cnt+1))
		for n in `seq 1 6`; do
			s="<NUM_${n}>"
			sed -i "s/${s}/${cnt}${n}/g" $fname
		done

		oIFS=$IFS
		IFS=
		while IFS=$'\n' read -r var ; do
			if [[ "$var" =~ "<REMOTETECH>" ]]; then
				v="${i}RemoteTech"
echo "v: $v"
echo "v = ${!v}"
				if [ "${!v}" == "AnyGigaDish" ]; then
					cat $rtgiga >>$fnameFinal
				else
					sed "s/<ANTENNA>/${!v}/g" <$rtantenna >>$fnameFinal
				fi
				cat $rt >>$fnameFinal	
			else
				echo $var >>$fnameFinal
			fi
		done <$fname
		IFS=$oIFS
		rm $fname
	fi
done

if [ "$1" != "clean" ]; then
	for i in $gasbodies; do
		echo "Gas body: $i"
		fname=${i}_unmanned.cfg
		sed -i '/<LANDING_FOLLOWS>/q' $fname
	done

	sed "s/<PLANETARYBODIES>/$files/g" <Makefile.template >Makefile
else
	cat >Makefile <<_EOF_
build:
	./build.sh
_EOF_
fi
