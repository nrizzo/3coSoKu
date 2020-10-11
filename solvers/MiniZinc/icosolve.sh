#!/bin/bash

if [ "$#" -eq 12 ] # if called with 12 arguments, use them as capacities
then
	instance=$(echo "cap = [$1, $2, $3, $4, $5, $6, $7, $8, $9, ${10}, ${11}, ${12}];")
	weights=$(cat input-ico.dzn | tail -n +2)

	echo -e "$instance\n$weights" | cat 3coSoKu.mzn - | minizinc --solver chuffed --input-from-stdin
else # otherwise use those of input-ico.dzn
	minizinc --solver chuffed 3coSoKu.mzn input-ico.dzn
fi
