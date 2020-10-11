#!/bin/bash

instance=$(echo "cap = [$1, $2, $3, $4, $5, $6, $7, $8, $9, ${10}, ${11}, ${12}];")
weights=$(cat input-ico.dzn | tail -n +2)

output=$(echo "$instance" | cat IcoSoKu.mzn input-ico.dzn - | \
	minizinc -v --solver gecode -r snubdisphenoid --input-from-stdin 2>&1)

if echo "$output" | grep --quiet UNSATISFIABLE
then
	echo "UNSAT instance!" >&2
	exit 1
else
	echo "$output" | grep Done | cut -d' ' -f7
fi
