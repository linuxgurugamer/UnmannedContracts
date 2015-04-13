#!/bin/bash

	parameterfile=template.cfg
        cnt=0
        while IFS=$'\n' read -r var ; do
                vars[$cnt]=$var
                cnt=$((cnt+1))
		if [[ "$var" =~ "<REMOTETECH>" ]]; then
			echo $var
		fi
        done < $parameterfile
        n=${#vars[@]}

