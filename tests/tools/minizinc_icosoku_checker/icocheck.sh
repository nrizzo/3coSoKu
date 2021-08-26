#!/bin/bash
# this script, given an instance of IcoSoKu and given the values of arrays tile,
# rot describing a solution (see the encodings), checks if the solution is
# correct using the MiniZinc model
# Usage: ./icocheck.sh "1 2 3 4 5 6 7 8 9 10 11 12" "1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 19 20 18" "0 2 0 0 1 0 2 0 1 1 0 1 0 0 0 2 0 0 0 0"
# ~ Nicola Rizzo and Agostino Dovier

# https://stackoverflow.com/questions/59895/how-can-i-get-the-source-directory-of-a-bash-script-from-within-the-script-itsel
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd "$SCRIPT_DIR"

instance=$(echo "cap = [$(echo $1 | sed 's/\ /\,\ /g')];")
tile="tile = array1d(FACE, [$(echo $2 | sed 's/\ /,\ /g')]);"
rot="rot = array1d(1..n, [$(echo $3 | sed 's/\ /,\ /g')]);"

output=$(echo -e "$instance\n$tile\n$rot" | cat IcoSoKu.mzn - | \
	minizinc --solver gecode --input-from-stdin 2>&1)

if echo "$output" | grep --quiet "evaluation error"
then
	echo "$output" >&2
	exit 1
fi

if echo "$output" | grep --quiet UNSATISFIABLE
then
	echo "UNSAT instance!" >&2
	exit 1
fi
