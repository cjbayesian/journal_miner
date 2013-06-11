#!/bin/bash

## Extract some statistics reported in journal articles

## Usage: ./extract_rsq.sh <data_path>
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

