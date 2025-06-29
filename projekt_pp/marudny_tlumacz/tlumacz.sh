#!/bin/zsh

unzip ../tlumacz.zip -d ./
dos2unix en-7*

cat en-7.2.json5 | awk ' BEGIN {print "{\n"} /":/ {print "//", $0,"\n",$0,"\n"} END {print "}"}' >> pl-7.2.json5

diff -u en-7.4.json5 en-7.2.json5 > en.patch

cat en.patch | awk 'BEGIN {print "{\n"} /- / {$1="";if(NR!=1) print "//  ",$0,"\n   ",$0,"\n"} END {print "}"}' > pl-7.4.json5