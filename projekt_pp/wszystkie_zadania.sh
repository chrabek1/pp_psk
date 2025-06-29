#!/bin/zsh

mkdir niesforne_dane
cd niesforne_dane
unzip ../dane.zip -d ./
dos2unix dane.txt
cat dane.txt | awk 'BEGIN {print "x\ty\tz"} ORS=(NR%3?"\t":RS) {print}' >> dane2.txt
cd ..

mkdir dodawanie_poprawek
cd dodawanie_poprawek
unzip ../lista.zip -d ./
dos2unix lista*
diff lista.txt lista-pop.txt > lista.patch
patch lista.txt < lista.patch
md5sum lista.txt
md5sum lista-pop.txt
cd .. 

mkdir csv_sql
cd csv_sql
unzip ../csv.zip -d ./
dos2unix *
cat steps-2sql.csv | awk 'BEGIN {FS=";"; OFS=""} {print "INSERT INTO stepsData (time, intensity, steps) VALUES (",$1,", ",$2,", ",$3,");"}' >> steps-2sql.sql
cat steps-2csv.sql | sed 's/^.*VALUES //g;s/[();]//g;s/, /;/g;s/000;/;/g' >> steps-2csv.csv
cd ..

mkdir marudny_tlumacz
cd marudny_tlumacz
unzip ../tlumacz.zip -d ./
dos2unix en-7*
cat en-7.2.json5 | awk ' BEGIN {print "{\n"} /":/ {print "//", $0,"\n",$0,"\n"} END {print "}"}' >> pl-7.2.json5
diff -u en-7.4.json5 en-7.2.json5 > en.patch
cat en.patch | awk 'BEGIN {print "{\n"} /- / {$1="";if(NR!=1) print "//  ",$0,"\n   ",$0,"\n"} END {print "}"}' > pl-7.4.json5
cd ..

mkdir fotografik
cd fotografik
unzip ../kopie\*.zip -d ./
rm kopie*
unzip \*.zip
rm *.zip
magick mogrify -format jpg *png
rm *.png
magick *.jpg -resize X720 -density 96 -units PixelsPerInch -set filename:fname '%t' '%[filename:fname].jpg'
zip kopie.zip *
cd ..

mkdir pdfy
cd pdfy
magick montage -page a4 -pointsize 72 -label '%f' -geometry +200+200 -tile 2x4 ../fotografik/*.jpg ./montage.pdf
cd ..

mkdir porzadki
cd porzadki
unzip ../kopie\*.zip -d ./
for plik in *.zip; do
  rok=${plik:0:4}
  miesiac=${plik:5:2}
  mkdir -p "$rok/$miesiac"
  cp "$plik" "$rok/$miesiac/"
done
Rm *.zip
cd ..

mkdir galeria
cd galeria
cp ../fotografik/*.jpg ./
html_output="<!DOCTYPE html>
<html>
<head>
  <meta charset=\"UTF-8\"
  <title>Dumb Image Gallery</title>
<style>
  .responsive {
    display: inline-block;
    padding: 5px;
    width: 200px;
    vertical-align: top;
  }
  .gallery img {
    width: 100%;
    height: auto;
    border: 2px solid black;
  }
  .desc {
    text-align: center;
    margin-top: 5px;
  }
</style>
</head>
<body>
  <h2>Dumb Image Gallery</h2>
  <h4>Foo Bar GraphiC DesigneR</h4>
"
for obraz in *.jpg; do
  html_output+="<div class="responsive">
		  <div class="gallery">
		    <a target="_blank" href="$obraz">
		      <img src="$obraz">
		    </a>
		  <div class="desc">$obraz</div>
		  </div>
		</div>"
done
html_output+="</body>\n</html>"
echo -e $html_output > galeria.html
cd ..
