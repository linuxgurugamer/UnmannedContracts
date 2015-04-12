#!/bin/bash


bodies="Minmus Moho Eve Gilly Duna Ike Dres Jool Laythe Tylo Vall Bop Eeloo Pol"

template=template.cfg
gasbodies="Jool"

files=""
cnt=570
for i in $bodies; do
	fname=${i}_unmanned.cfg
	files="$files $fname"
	if [ "$1" = "clean" ]; then
		rm  $fname 
		rm -f Makefile
	else
		cp $template $fname
		sed -i "" "s/<PLANETARYBODY>/${i}/g" $fname
		cnt=$((cnt+1))
		for n in `seq 1 6`; do
			s="<NUM_${n}>"
			sed -i "" "s/${s}/${cnt}${n}/g" $fname
		done
	fi
done


if [ "$1" != "clean" ]; then
	for i in $gasbodies; do
		fname=${i}_unmanned.cfg
		sed -i "" '/<LANDING_FOLLOWS>/q;p' $fname
	done

	sed "s/<PLANETARYBODIES>/$files/g" <Makefile.template >Makefile
else
	cat >Makefile <<_EOF_
build:
	./build.sh
_EOF_
fi
