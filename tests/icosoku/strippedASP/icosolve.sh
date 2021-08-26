#!/bin/bash

instance=$(echo "cap(a, $1). cap(b, $2). cap(c, $3). cap(d, $4). cap(e, $5). cap(f, $6). cap(g, $7). cap(h, $8). cap(i, $9). cap(j, ${10}). cap(k, ${11}). cap(l, ${12}).")
output=$(echo "$instance" | cat IcoSoKu.lp input-ico.lp - | clingo)

if echo "$output" | grep --quiet UNSATISFIABLE
then
	echo "UNSAT instance!" >&2
	exit 1
elif echo "$output" | grep --quiet SATISFIABLE
then # success
	sol=$(echo "$output" | grep -B1 SATISFIABLE | head -n 1 | tr " ," "\n\t")
	tile=$(echo "$sol" | grep assign | cut -d'(' -f2 | cut -d')' -f1 | sort -k2 | cut -f1 | tr "\n" " ")
	rot=$(echo "$sol" | grep rotate | cut -d'(' -f2 | cut -d')' -f1 | sort -k1 -n | cut -f2 | tr "\n" " ")
	echo -e "$tile\t$rot"
	exit 0
else
	echo "Unexpected error in clingo output!" >&2
	exit 2
fi
