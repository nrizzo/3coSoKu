#!/bin/bash

IFS=' ' read -r -a cap <<< "$1"
IFS=' ' read -r -a fixedfaces <<< "$2"
IFS=' ' read -r -a fixedtiles <<< "$3"

instance=""
v=(a b c d e f g h i j k l)
for ((i = 0; i < 12; i++))
do
	instance+="cap(${v[$i]}, ${cap[$i]}). "
done

constraints=""
for ((i = 0; i < ${#fixedfaces[@]}; i++))
do
	constraints+="assign(${fixedtiles[$i]}, ${fixedfaces[$i]}). "
done


output=$(echo -e "$instance\n$constraints" | cat IcoSoKu.lp input-ico.lp - | \
	clingo)

if echo "$output" | grep --quiet UNSATISFIABLE
then
	echo "$output" | grep "CPU Time" | cut -d' ' -f8 | tr -d "s"
else
	echo "Error!" >&2
	exit 1
fi
