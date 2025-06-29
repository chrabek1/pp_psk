#!/bin/zsh

unzip ../kopie\*.zip -d ./

for plik in *.zip; do
  rok=${plik:0:4}
  miesiac=${plik:5:2}

  mkdir -p "$rok/$miesiac"

  cp "$plik" "$rok/$miesiac/"

done

Rm *.zip