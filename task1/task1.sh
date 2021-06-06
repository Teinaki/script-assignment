#!bin/bash

file=$1
IFS=";"
while read col1 col2 col3 col4
do
echo "Column 1 value: $col1"

IFS='.'
read -a strarr <<< "$col1"
firstname="${strarr[0]}"
echo "${firstname:0:1}${strarr[1]}" | cut -f1 -d"@"



echo "Column 2 value: $col2"
echo "Column 3 value: $col3" | tr -d /
echo "Column 4 value: $col4"
sudo useradd $col1
sudo echo "$col1:$col2" | sudo chpasswd
done < $file