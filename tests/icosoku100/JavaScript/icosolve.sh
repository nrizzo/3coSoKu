#!/bin/bash

# if called with 12 arguments, use them as capacities
if [ "$#" -eq 12 ]
then
	# taking care of the difference in the naming of the vertices
	args=(${@})
	input="${args[0]}, ${args[2]}, ${args[3]}, ${args[4]}, ${args[5]}, ${args[1]}, ${args[10]}, ${args[9]}, ${args[8]}, ${args[7]}, ${args[6]}, ${args[11]}"

	sed -i "s/icosolve(\[.*/icosolve([$input]);/" solver.js
fi

node solver.js | grep -v SOLUTION
