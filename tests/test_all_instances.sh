#!/bin/bash
# using a stripped down version of the ASP encoding, it verifies that all
# IcoSoKu instances, or more precisely the instances in output of
# good_instances.c, admit a solution.

gcc good_instances.c -o strippedASP/good_instances

cd strippedASP
time \
	./good_instances | \
	parallel --verbose --col-sep " " --halt soon,fail=1 \
	./icosolve.sh
