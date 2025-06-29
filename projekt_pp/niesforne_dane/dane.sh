#!/bin/zsh

unzip ../dane.zip -d ./
dos2unix dane.txt
cat dane.txt | awk 'BEGIN {print "x\ty\tz"} ORS=(NR%3?"\t":RS) {print}' >> dane2.txt
