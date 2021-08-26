#!/bin/bash

instance=$(echo "cap(a, $1). cap(b, $2). cap(c, $3). cap(d, $4). cap(e, $5). cap(f, $6). cap(g, $7). cap(h, $8). cap(i, $9). cap(j, ${10}). cap(k, ${11}). cap(l, ${12}).")
output=$(echo "$instance" | cat IcoSoKu.lp input-ico.lp - | clingo --seed 40)

if echo "$output" | grep --quiet UNSATISFIABLE
then
	echo "UNSAT instance!" >&2
	exit 1
else
	echo "$output" | grep "CPU Time" | cut -d' ' -f8 | tr -d "s"
fi
