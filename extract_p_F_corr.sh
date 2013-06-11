#!/bin/bash

## Extract some statistics reported in journal articles

## Usage: ./extract_p_F_corr <data_path>
## <data_path> is a folder containing raw text of all articles
## as individually named text files with extention .txt

cd $1

# R-squared
touch ../rsq.csv
rm ../rsq.csv

for fname in *.txt
do
   pattern="([^0-9a-z\']|^)r(2|[^0-9a-z]*squared) *[^0-9]{0,1} *0[^0-9a-z][0-9]+"
   cat "$fname" | egrep -oi "$pattern" |
   egrep -o "0[^0-9][0-9]+$" |
   sed -r 's/[^0-9]/\./g' |
   sed "s/^/\"$fname\",/"  >> ../rsq.csv

   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi

   ## Naked decimals
   pattern="([^0-9a-z\']|^)r(2|[^0-9a-z]*squared) *[^0-9]{0,1} *\.[0-9]+"
   cat "$fname" | egrep -oi "$pattern" |
   egrep -o "[^0-9][0-9]+$" |
   sed -r 's/[^0-9]/0\./g' |
   sed "s/^/\"$fname\",/"  >> ../rsq.csv

   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi
done


# Derive R-squared from correlation coeff.
touch ../corr_r.csv
rm ../corr_r.csv
for fname in *.txt
do
   pattern="([^0-9a-z\']|^)r[s ]*[^0-9]{0,1} *\-*0[^0-9a-z][0-9]+"
   cat "$fname" | egrep -oi "$pattern" |
   egrep -o "0[^0-9][0-9]+" |      ##<<-fix this. Retain (-)tve.
   sed -r 's/[^0-9]/\./' |
   sed "s/^/\"$fname\",/" >> ../corr_r.csv

   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi

   ## Naked decimals
   pattern="([^0-9a-z\']|^)r[s ]*[ϭ¼ =><] *\-*\.[0-9]+"
   cat "$fname" | egrep -oi "$pattern" |
   egrep -o "\.[0-9]+" |      ##<<-fix this. Retain (-)tve.
   sed -r 's/\./0\./' |
   sed "s/^/\"$fname\",/" >> ../corr_r.csv

   ## Watch raw matches ##
   res=`cat "$fname" | egrep -io "$pattern"`
   if [ "$res" != "" ]; then
     echo "$fname $res"
   fi
done



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


