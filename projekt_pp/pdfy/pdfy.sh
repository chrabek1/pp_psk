#!/bin/zsh

mkdir montage

magick montage -page a4 -pointsize 72 -label '%f' -geometry +200+200 -tile 2x4 ../fotografik/*.jpg ./montage.pdf
