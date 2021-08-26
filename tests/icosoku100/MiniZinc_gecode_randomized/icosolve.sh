#!/bin/bash

instance=$(echo "cap = [$1, $2, $3, $4, $5, $6, $7, $8, $9, ${10}, ${11}, ${12}];")
output=$(echo "$instance" | cat IcoSoKu.mzn input-ico.dzn - | \
	minizinc --verbose \
		--solver gecode \
		--input-from-stdin \
		--fzn-flags "--rnd-seed 40" 2>&1)

if echo "$output" | grep --quiet UNSATISFIABLE
then
	echo "UNSAT instance!" >&2
	exit 1
else
	totaltime=$(echo "$output" | grep Done | cut -d' ' -f7)
	compiletime=$(echo "$output" | grep -B 2 "SOLVING PHASE" | head -n 1 | \
		cut -d'(' -f2 | cut -d' ' -f1 | tr "\n" " ")
	echo "$totaltime $compiletime"
fi
