#!/bin/zsh

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

# Pętla po wszystkich plikach graficznych w folderze
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

# Zakończenie HTML-a
html_output+="</body>\n</html>"

# Zapisz do pliku
echo -e $html_output > galeria.html