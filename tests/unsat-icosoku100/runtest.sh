#!/bin/bash
# this script generates a batch of tests to measure the performance of solvers
# MiniZinc w/ Gecode, MiniZinc w/ Chuffed and ASP w/ clingo on random instances
# of unsat-IcoSoKu, i.e. a version of IcoSoKu where one of the 12 capacities of
# IcoSoKu is incremented by 1 and $n tiles are randomly fixed;
# the output is saved in the folder output_unsat_icosoku100
# ~ Nicola Rizzo and Agostino Dovier

face=(ABC ACD ADE AEF AFB BFK BGC BKG CGH CHD DHI DIE EIJ EJF FJK GKL GLH HLI ILJ JLK)
outputfolder="output_unsat_icosoku100"
seed="tetrahedron"
n=4
N=100

get_random_data()
{
	openssl enc -aes-256-ctr \
		-pass pass:"$seed" \
		-nosalt \
		</dev/zero 2>/dev/null
	# https://www.gnu.org/software/coreutils/manual/html_node/Random-sources.html
}

mkdir $outputfolder

echo -n "Generating batch of tests... "
echo -n > $outputfolder/batch
get_random_data | for ((i = 1; i <= N; i++))
do
	# shuf is used to generate pseudo-random unsat-IcoSoKu instances
	cap=($(shuf -i1-12 --random-source=/dev/stdin | tr "\n" " "))
	c=$(shuf -i0-11 -n 1 --random-source=/dev/stdin)
	cap[$c]=$(( ${cap[$c]} + 1 ))

	fixedfaces=()
	while read line
	do
		fixedfaces+=(${face[$line]})
	done <<< $(shuf -i0-19 -n $n --random-source=/dev/stdin)

	fixedtiles=$(shuf -i1-20 -n $n --random-source=/dev/stdin | tr "\n" " ")
	echo -e "${cap[@]}\t${fixedfaces[@]}\t${fixedtiles[@]}" >> $outputfolder/batch
done
echo "done (batch)."

# MiniZinc tests
echo -n "Testing MiniZinc model - Gecode... "
echo -n > $outputfolder/times_minizinc_gecode
cd MiniZinc_gecode
while read line
do
	cap=$(echo "$line" | cut -f1)
	fixedfaces=$(echo "$line" | cut -f2)
	fixedtiles=$(echo "$line" | cut -f3)
	./unsat-icosolve.sh \
		"$cap" "$fixedfaces" "$fixedtiles" \
		>> ../$outputfolder/times_minizinc_gecode
done < ../$outputfolder/batch
cd ..
echo "done."

echo -n "Testing MiniZinc model - Chuffed... "
echo -n > $outputfolder/times_minizinc_chuffed
cd MiniZinc_chuffed
while read line
do
	cap=$(echo "$line" | cut -f1)
	fixedfaces=$(echo "$line" | cut -f2)
	fixedtiles=$(echo "$line" | cut -f3)
	./unsat-icosolve.sh \
		"$cap" "$fixedfaces" "$fixedtiles" \
		>> ../$outputfolder/times_minizinc_chuffed
done < ../$outputfolder/batch
cd ..
echo "done."

# ASP tests
echo -n "Testing ASP model... "
echo -n > $outputfolder/times_asp
cd ASP
while read line
do
	cap=$(echo "$line" | cut -f1)
	fixedfaces=$(echo "$line" | cut -f2 | tr '[:upper:]' '[:lower:]')
	fixedtiles=$(echo "$line" | cut -f3)
	./unsat-icosolve.sh \
		"$cap" "$fixedfaces" "$fixedtiles" \
		>> ../$outputfolder/times_asp
done < ../$outputfolder/batch
cd ..
echo "done."
