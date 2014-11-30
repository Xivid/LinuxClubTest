#!/bin/bash
if [ $# -ne 3 ]; then echo 'Usage: replace.sh file w1 w2'; exit; fi
echo "Searching for \"$2\" from $1..."
echo -n "Matches found:"
grep -o $2 $1 | wc -l
echo "Replace all of them by \"$3\"?(Y or N)"
read answer
case $answer in 
[Yy])
cat $1 | while read line; do echo ${line//$2/$3}; done > __temp;
mv __temp $1;
echo "Done."
;;  
esac


