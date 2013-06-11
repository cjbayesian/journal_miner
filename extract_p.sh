#!/bin/bash

## Extract some statistics reported in journal articles

## Usage: ./extract_p.sh <data_path>
## <data_path> is a folder containing raw text of all articles
## as individually named text files with extention .txt


## Pull p-values for file $fname
touch ../all_p_values.csv
rm ../all_p_values.csv

for fname in *.txt
do
   pattern="([^0-9a-z\']|^)p *[^0-9a-z] *0[^0-9a-z][0-9]+"
   cat "$fname" | egrep -io "$pattern" |
   egrep -o "0[^0-9][0-9]+$" |
   sed -r 's/[^0-9]/\./g' |
   sed "s/^/\"$fname\",/" >> ../all_p_values.csv
   
   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi 

   ## Naked decimals.
   pattern="([^0-9a-z\']|^)p *[ϭ¼=>< ] *\.[0-9]+"
   cat "$fname" | egrep -io "$pattern" |
   egrep -o "\.[0-9]+$" |
   sed -r 's/\./0\./g' |
   sed "s/^/\"$fname\",/" >> ../all_p_values.csv
   
   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi 
done
#*P < 0·01

## For investigating potential false negative.
liberalpattern="[^0-9a-z]p *[^0-9a-z\(\] *0{0,1}[^0-9a-z \(\][0-9]+"








