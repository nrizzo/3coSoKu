#!/bin/bash
# generates a random instance of IcoSoKu by modifying the first twelve lines
# of input-ico.lp

randperm=()
for i in $(shuf -i 1-12 | tr "\n" " "); do randperm+=("$i"); done

foo=""
j=0
for i in a b c d e f g h i j k l
do
	foo+="cap($i, ${randperm[$j]}).\n"
	j=$(($j + 1))
done

weightline=$(grep -n weight input-ico.lp | cut -d ':' -f1)

bar=$(tail -n "+$weightline" input-ico.lp)

echo -e "$foo$bar" > input-ico.lp
