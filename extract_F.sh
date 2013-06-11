#!/bin/bash

## Extract some statistics reported in journal articles

## Usage: ./extract_F.sh <data_path>
## <data_path> is a folder containing raw text of all articles
## as individually named text files with extention .txt

cd $1

## F ratios
touch ../f_ratio.csv
rm ../f_ratio.csv
fpattern="([^0-9a-z]|^)f *[0-9]+ *, *[0-9]+ *[^0-9a-z] *[0-9]+[^0-9a-z][0-9]+"
 for fname in *.txt
   do 
   cat "$fname" | egrep -io  "$fpattern" | 
   sed -r 's/^[^0-9]+//g' |
   sed -r 's/[^0-9]/ /g' |
   sed -r 's/[ ]+/ /g' | 
   awk '{print $1 "," $2 "," $3 "." $4}' |
   sed "s/^/\"$fname\",/" >> ../f_ratio.csv

   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$fpattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi 
done


## F ratio with associated p-value.
touch ../f_with_p_values.csv
rm ../f_with_p_values.csv
pattern="$fpattern.{1,5}P[^0-9a-z]{1,2}0[^0-9a-z][0-9]+"
for fname in *.txt
do
   cat "$fname" | egrep -io "$pattern" |
   sed 's/[^0-9]/ /g' | 
   sed -r 's/ {2,}/ /g' | 
   awk '{print $1","$2","$3"."$4","$5"."$6}' |
   sed "s/^/\"$fname\",/" >> ../f_with_p_values.csv
   
   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi 
done

