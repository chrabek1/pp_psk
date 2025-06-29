#!/bin/zsh

unzip ../csv.zip -d ./
dos2unix *

cat steps-2sql.csv | awk 'BEGIN {FS=";"; OFS=""} {print "INSERT INTO stepsData (time, intensity, steps) VALUES (",$1,", ",$2,", ",$3,");"}' >> steps-2sql.sql

cat steps-2csv.sql | sed 's/^.*VALUES //g;s/[();]//g;s/, /;/g;s/000;/;/g' >> steps-2csv.csv