#!/bin/bash
# generates a random instance of IcoSoKu by modifying the first line of
# input-ico.dzn

foo="cap = [$(shuf -i 1-12 | tr "\n" "," | cut -d',' -f1-12)];"
bar="$(tail -n +2 input-ico.dzn)"
echo -e "$foo\n$bar" > input-ico.dzn
