#!/bin/bash
# generates a batch of tests to measure the performance of the solvers of these
# solvers on instances of IcoSoKu:
#  - MiniZinc w/ Gecode;
#  - MiniZinc w/ Gecode + randomized search, constant restart; 
#  - MiniZinc w/ Chuffed;
#  - ASP w/ clingo;
#  - JavaScript w/ node.js;
# saves the output in the folder output_icosoku100.

outputfolder="output_icosoku100"
seed="tetrahedron"
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
	# shuf is used to generate pseudo-random IcoSoKu instances
	shuf -i1-12 \
		--random-source=/dev/stdin | \
		tr "\n" " " >> $outputfolder/batch
	echo >> $outputfolder/batch
done
echo "done."

# MiniZinc tests
echo -n "Testing MiniZinc model - Gecode... "
echo -n > $outputfolder/times_minizinc_gecode
cd MiniZinc_gecode
while read line
do
	./icosolve.sh $line >> ../$outputfolder/times_minizinc_gecode
done < ../$outputfolder/batch
cd ..
echo "done."

echo -n "Testing MiniZinc model - Gecode, randomized search + constant restart... "
echo -n > $outputfolder/times_minizinc_gecode_random_restart
cd MiniZinc_gecode_randomized
while read line
do
	./icosolve.sh $line >> ../$outputfolder/times_minizinc_gecode_random_restart
done < ../$outputfolder/batch
cd ..
echo "done."

echo -n "Testing MiniZinc model - Chuffed... "
echo -n > $outputfolder/times_minizinc_chuffed
cd MiniZinc_chuffed
while read line
do
    ./icosolve.sh $line >> ../$outputfolder/times_minizinc_chuffed
done < ../$outputfolder/batch
cd ..
echo "done."

# ASP tests
echo -n "Testing ASP model... "
echo -n > $outputfolder/times_asp
cd ASP
while read line
do
	./icosolve.sh $line >> ../$outputfolder/times_asp
done < ../$outputfolder/batch
cd ..
echo "done."

# JavaScript tests
# check if the js solver is present
if [[ $(wc -l JavaScript/solver.js | cut -d " " -f1) -le 50 ]]; then
	exit 0
fi

echo -n "Testing Javascript model... "
echo -n > $outputfolder/times_js
cd JavaScript
while read line
do
    ./icosolve.sh $line >> ../$outputfolder/times_js
done < ../$outputfolder/batch
cd ..
echo "done."
