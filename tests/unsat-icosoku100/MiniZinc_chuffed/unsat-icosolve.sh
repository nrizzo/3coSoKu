#!/bin/bash

instance=$(echo "cap = [$(echo $1 | sed 's/\ /,\ /g')];")
IFS=' ' read -r -a fixedfaces <<< "$2"
IFS=' ' read -r -a fixedtiles <<< "$3"

constraints=""
for ((i = 0; i < ${#fixedfaces[@]}; i++))
do
	constraints+="constraint tile[${fixedfaces[$i]}] == ${fixedtiles[$i]}; "
done

output=$(echo -e "$instance\n$constraints" | cat IcoSoKu.mzn input-ico.dzn - | \
	minizinc --verbose \
		--solver chuffed \
		--input-from-stdin \
		--fzn-flags "--rnd-seed 40" 2>&1)

if echo "$output" | grep --quiet "model inconsistency detected"
then
	totaltime=$(echo "$output" | grep Done | cut -d' ' -f7)
	compiletime=$(echo "$output" | grep -B 2 "max stack depth" | head -n 1 | \
		cut -d'(' -f2 | cut -d' ' -f1 | tr "\n" " ")
	echo "$totaltime $compiletime model_inconsistency_detected"
elif echo "$output" | grep --quiet UNSATISFIABLE
then
	totaltime=$(echo "$output" | grep Done | cut -d' ' -f7)
	compiletime=$(echo "$output" | grep -B 2 "SOLVING PHASE" | head -n 1 | \
		cut -d'(' -f2 | cut -d' ' -f1 | tr "\n" " ")
	echo "$totaltime $compiletime"
else
	echo "Error!" >&2
	exit 1
fi
