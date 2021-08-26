#!/bin/bash
# this script, given an instance of IcoSoKu and given the values of arrays tile,
# rot describing a solution (see the encodings), checks if the solution is
# correct
# Usage: ./icocheck.sh "1 2 3 4 5 6 7 8 9 10 11 12" "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 19 20 18" "0 2 0 0 1 0 2 0 1 1 0 1 0 0 0 2 0 0 0 0"
# ~ Nicola Rizzo and Agostino Dovier

face=(ABC ACD ADE AEF AFB BFK BGC BKG CGH CHD DHI DIE EIJ EJF FJK GKL GLH HLI ILJ JLK)
weight=(000 001 002 003 011 012 012 012 021 021 021 022 033 111 123 123 132 132 222 333)
cap=($1); tile=($2); rot=($3)

declare -A fill; for c in {A..L}; do fill[c]=0; done

# putting each weight on the corresponding vertex
for ((i = 0; i < 20; i++))
do
	t=$(( ${tile[$i]} - 1 ))
	r=${rot[$t]}
	for j in 0 1 2
	do
		v=${face[$i]:$j:1}
		k=$(( (3 + $j - $r) % 3 ))
		fill[$v]=$(( ${fill[$v]} + ${weight[$t]:$k:1} ))
	done
done

# checking if the capacities are satisfied
i=0
for c in A B C D E F G H I J K L
do
	if [[ ${fill[$c]} -ne ${cap[$i]} ]] ; then
		echo "Solution is wrong for input \"$1\" \"$2\" \"$3\"!"
		exit 1
	fi
	i=$(( $i + 1 ))
done

exit 0
