#!/bin/zsh

unzip ../lista.zip -d ./
dos2unix lista*
diff lista.txt lista-pop.txt > lista.patch
patch lista.txt < lista.patch
md5sum lista.txt
md5sum lista-pop.txt