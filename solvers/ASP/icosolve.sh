#!/bin/bash

if [ "$#" -eq 12 ] # if called with 12 arguments,
then # use them as capacities
	instance=$(echo "cap(a, $1). cap(b, $2). cap(c, $3). cap(d, $4). cap(e, $5). cap(f, $6). cap(g, $7). cap(h, $8). cap(i, $9). cap(j, ${10}). cap(k, ${11}). cap(l, ${12}).")
	weights=$(cat input-ico.lp | grep -v cap)
	echo -e "$instance\n$weights" | cat 3coSoKu.lp variants/ico.lp - | clingo
else # otherwise use those of input-ico.lp
	clingo 3coSoKu.lp variants/ico.lp input-ico.lp
fi
