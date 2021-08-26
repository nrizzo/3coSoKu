#!/bin/bash
# using a stripped down version of the ASP encoding plus GNU parallel,
# this script
# 1) verifies that all IcoSoKu instances (or more precisely the instances in
# 	output of good_instances.c) admit a solution;
# 2) it checks each solution with the Bash program in ../tools/icocheck.sh;
# 3) it checks each solution with the MiniZinc model in
# 	../tools/minizinc_icosoku_checker;
# plus, it saves the instances, their solutions and the log of the three parts
# in the folder output_icosoku
# ~ Nicola Rizzo and Agostino Dovier

outputfolder="output_icosoku"
mkdir $outputfolder

echo -n "Generating instances..."
gcc good_instances.c -o good_instances
./good_instances > "./$outputfolder/instances"
echo " done."

echo -n "Solving instances..."
cd strippedASP
time \
	cat "../$outputfolder/instances" | \
	parallel --col-sep " " --halt soon,fail=1 --keep-order \
		--joblog "../$outputfolder/joblog_solving" \
		./icosolve.sh \
	> "../$outputfolder/solutions"
echo "done."
cd ..

cd "./$outputfolder"
echo -n "Validating solutions with the Bash script..."
time \
	paste instances solutions | \
	parallel --col-sep "\t" --halt soon,fail=1 \
		--joblog "../$outputfolder/joblog_check1" \
		../../tools/icocheck.sh
echo " done."
echo -n "Validating solutions with the MiniZinc model..."
time \
	paste instances solutions | \
	parallel --col-sep "\t" --halt soon,fail=1 \
		--joblog "../$outputfolder/joblog_check2" \
		../../tools/minizinc_icosoku_checker/icocheck.sh
echo " done."
