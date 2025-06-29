#!/bin/zsh

unzip ../kopie\*.zip -d ./
rm kopie*
unzip \*.zip
rm *.zip

magick mogrify -format jpg *png
rm *.png

magick *.jpg -resize X720 -density 96 -units PixelsPerInch -set filename:fname '%t' '%[filename:fname].jpg'

zip kopie.zip *