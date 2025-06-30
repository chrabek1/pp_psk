# Dokumentacja projektu z przedmiotu Podstawy Programowania

*Radosław Kulig s093795
Piotr Łukawski s096942*
### Wstęp

W repozytorium w folderach z poszczególnymi zadaniami znajdują się skrypty **sh** z rozwiązaniem zadania jak i generowane przez nie pliki z pominięciem tych, których rozmiar przekracza 100MB.

Pracowaliśmy na systemie MacOS więc każdy skrypt uwzględnia konwersje **dos2unix**.

Skrypt *wszystkie_zadania.sh* zawiera w sobie rozwiązanie wszystkich zadań, uruchomiony w katalogu ze wszystkimi plikami .zip utworzy katalogi dla każdego zadania i wygeneruje rozwiązania.

Wykonanie skryptów *pdfy.sh* i *galeria.sh* wymaga wcześniejszego wykonania skryptu *fotografik.sh*
Poniżej przedstawiamy rozwiązania zadań projetktowych.

#### [Link do repozytorium github projektu](https://github.com/chrabek1/pp_psk)

### Używane polecenia
- **cat** – wyświetla zawartość plików tekstowych w terminalu.
- **head** - wyświetla początkowe linie pliku (domyślnie 10 pierwszych).
- **unzip** - rozpakowuje pliki z archiwum ZIP.
- **zip** - pakuje pliki do archiwum.
- **rm** - usuwa pliki
- **grep** – wyszukuje linie pasujące do podanego wzorca w plikach tekstowych.
- **sed** – wykonuje operacje przetwarzania tekstu (np. zamiany) na podstawie wyrażeń regularnych.
- **awk** – analizuje i przetwarza dane tekstowe.
- **diff** – porównuje dwa pliki lub katalogi i pokazuje różnice między nimi.
- **patch** – wprowadza zmiany do pliku na podstawie danych wygenerowanych przez diff.
- **cp** – kopiuje pliki i katalogi.
- **mkdir** – tworzy nowe katalogi.
- **md5sum** – oblicza i wyświetla sumę kontrolną MD5 pliku (do sprawdzania integralności).
- **magick mogrify** - konwertuje obrazy.
- **magick montage** - łączy wiele obrazów w jeden kolaż, układając je w siatkę i umożliwiając dodanie etykiet, ramek oraz dostosowanie rozmiaru i odstępów między nimi.

## Rozwiązania:
#### Niesforne dane
##### skrypt:

```
unzip ../dane.zip -d ./
dos2unix dane.txt
cat dane.txt | awk 'BEGIN {print "x\ty\tz"} ORS=(NR%3?"\t":RS) {print}' > dane2.txt
```
##### Opis rozwiązania:
Rozpakowujemy plik *dane.zip* i konwertujemy go. 
Poleceniem **cat** przekazujemy plik dane.txt do **AWK** które najpierw `BEGIN` wypisuje pierwszy wiersz `"x y z"` oddzielone tabulatorami, a następnie wypisuje wszystkie linie z pliku *dane.txt* w 3 kolumnach(jako wyjściowy separator wierszy `ORS` ustalamy `"\t"`, chyba że numer wiersza jest podzielny przez trzy, wtedy jest to `RS` czyli znak nowej linii `"\n"`. 
Zapisuje wynik do pliku *dane2.txt*.

#### Dodawanie poprawek
##### skrypt:
```
unzip ../lista.zip -d ./
dos2unix lista*
diff lista.txt lista-pop.txt > lista.patch
patch lista.txt < lista.patch
md5sum lista.txt
md5sum lista-pop.txt
```
##### Opis rozwiązania:
Rozpakowujemy i konwertujemy dane do zadania. 
Komendą **diff** ustalamy różnice pomiędzy plikami i tworzymy "łatkę" *lista.patch*.
Plik *lista.patch* opisuje jakie dane należu dodać/usunąć/zmodyfikować aby z pliku *lista.txt* otrzymać plik identyczny do *lista-pop.txt*.
Poleceniem **path** wprowadzamy te zmiany do pliku *lista.txt*. 
Poleceniem **md5sum** porównujemy sumy kontrolne plików *lista.txt* i *lista-pop.txt* aby sprawdzić czy są identyczne
#### Z CSV do SQL i z powrotem
##### skrypt:
```
unzip ../csv.zip -d ./
dos2unix *
cat steps-2sql.csv | awk 'BEGIN {FS=";"; OFS=""} {print "INSERT INTO stepsData (time, intensity, steps) VALUES (",$1,", ",$2,", ",$3,");"}' >> steps-2sql.sql
cat steps-2csv.sql | sed 's/^.*VALUES //g;s/[();]//g;s/, /;/g;s/000;/;/g' > steps-2csv.csv
```
##### Opis rozwiązania:
Rozpakowujemy i konwertujemy dane do zadania. 
Poleceniem cat przekazujemy plik *steps-2sql.csv* do **AWK**, które najpierw `BEGIN` ustala separator pól na średnik `";"`, a wyjściowy separator jako brak znaku `""`, a następnie dla każdego wiersza pliku *steps2-sql.csv* wypisuje Tekst: `"INSERT INTO stepsData (time, intensity, steps) VALUES (",$1,", ",$2,", ",$3,");"` W miejse `$1`, `$2`, `$3` wstawiając dane z odpowiednio 1, 2 i 3 kolummy.
Wynik zapisuje do pliku *steps-2csv.csv*.
Kolejnym poleceniem cat przekazujemy plik *steps-2csv.sql* do SEDa który poleceniem `s/^.*VALUES //g` każde wystąpienie(`/g`) wzorca `/^.VALUES /`(czyli początek wiersza do VALUES włącznie) zastępuje `//` (czyli niczym, usuwa to). 
Następnie poleceniem `s/[();]//g` usuwa wszystkie średniki i nawiasy okrągłe, `s/, /;/g` zastępuje przecinki średnikiem, a polecenie `s/000;/;/g` zastępuje trzy zera zakończone średnikiem samym średnikiem.
Wynik zapisuje do pliku *steps-2csv.csv*.

#### Marudny tłumacz

##### skrypt:
```
unzip ../tlumacz.zip -d ./
dos2unix en-7*

cat en-7.2.json5 | awk ' BEGIN {print "{\n"} /":/ {print "//", $0,"\n",$0,"\n"} END {print "}"}' >> pl-7.2.json5

diff -u en-7.4.json5 en-7.2.json5 > en.patch

cat en.patch | awk 'BEGIN {print "{\n"} /- / {$1="";if(NR!=1) print "//  ",$0,"\n   ",$0,"\n"} END {print "}"}' > pl-7.4.json5
```
##### Opis rozwiązania:
Rozpakowujemy i konwertujemy dane do zadania.
Poleceniem **cat** przekazujemy plik *en-7.2.json5* do **AWK**, które najpierw `Begin` drukuje otwarcie nawiasu klamrowego `{`, a następnie dwukrotnie drukuje każdy wiersz `$0`, raz poprzedzając go oznaczeniem komentarza `//`, na końcu `END` drukuje zamknięcie nawiasu klamrowego `}`.
Wynik zapisuje do pliku *pl-7.2.json5*.
Poleceniem **diff -u** zapisujemy do pliku *en.pacth* różnice między plikami *en-7.4.json5 en-7.2.json5* w formacie ujednoliconym (flaga **-u**).
Poleceniem cat przekazujemy plik *en.patch* do **AWK**, które najpierw `BEGIN` drukuje otwarcie nawiasu klamrowego `{` i znak nowej linii, następnie dwuktrotnie drukuje każdy wiersz zaczynający się od minusa `/- /`(czyli te wiersze z *en-7.4.json5* których brakuje w *en-7.2.json5*), raz poprzedając go oznaczeniem komentarza `//`. Wcześniej usuwa pierwsze pole `$1=""` , czyli właśnie `- `. Na końcu `END` drukuje zamknięcie nawiasu klamrowego `}`. 
Wynik zapisuje do pliku pl-7.4.json5
#### Fotografik gamoń
##### skrypt:
```
unzip ../kopie\*.zip -d ./
unzip \*.zip
rm *.zip

magick mogrify -format jpg *png
rm *.png

magick *.jpg -resize X720 -density 96 -units PixelsPerInch -set filename:fname '%t' '%[filename:fname].jpg'

zip kopie.zip *
```
##### Opis rozwiązania:
Rozpakowujemy wszystkie dane i usuwamy zbędne archiwa.
Poleceniem **magic mogrify** zmieniamy format obrazów *.png* na *.jpg*, a następnie usuwamy zbędne pliki *.png*.
Poleceniem **magic** formatujemy wszystkie pliki *.jpg* ustalając ich wysokość na 720 px zachowując proporcje `-resize X720`, rozdzielczość na 96 DPI `-density 96`, jednostkę rozdzielczości jako pixele na cal i nadpisujemy plik każdy nadając mu taką samą nazwę `-set filename:fname '%t' '%[filename:fname].jpg`.
#### Wszędzie te PDF-y
##### skrypt:
```
magick montage -page a4 -pointsize 72 -label '%f' -geometry +200+200 -tile 2x4 ../fotografik/*.jpg ./montage.pdf
```
##### Opis rozwiązania:
Poleceniem **magic montage** tworzymy kolaż z obrazów *.jpg* z poprzedniego zadania rozmieszczając je na stronach a4 `-page a4` w układzie 2x4 `-tile 2x4`, z podpisami nazw plików `-label %f` o czcionce w rozmiarze 72 `-pointsize 72`, z marginesem 200px w pionie i poziomie`-geometry +200+200` i zapisujemy go do pliku w formacie *.pdf* `./montage.pdf`.
#### Porządki w kopiach zapasowych
##### skrypt:
```
unzip ../kopie\*.zip -d ./
for plik in *.zip; do
  rok=${plik:0:4}
  miesiac=${plik:5:2}
  mkdir -p "$rok/$miesiac"
  cp "$plik" "$rok/$miesiac/"
done
rm *.zip
```
##### Opis rozwiązania:
Rozpakowujemy dane do zadania.
W pętli **for** dla każdego pliku *.zip* określamy dla niego rok `rok=${plik:0:4}` oraz miesiąc `miesiac=${plik:5:2}` i tworzymy odpowiedni katalog wraz z katalogiem pośrednim `mkdir -p "$rok/$miesiac"`, przekopiowujemy do niego nasz plik `cp "$plik" "$rok/$miesiac/"`. Kończymy pętle i usuwamy niepotrzebne pliki z katalogu głównego `rm *.zip`.
#### Galeria dla grafika
##### skrypt:
```
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
```
##### Opis rozwiązania:
Kopiujemy pliki z zadania fotografik gamoń do do katalogu z tym zadaniem. Do zmiennej `html_output` przypisujemy szkic html naszej strony zawierający podstawowe formatowanie i style.
W pętli **for** dla każdego obrazy .jpg dodajemy do zmiennej `html_output` diva wyświetlającego nasz obrazek wraz z podpisem z nazwą pliku, tak jak to zostało przedstawione w poleceniu zadania i kończymy pętlę. 
Dodajemy jeszcze zakończenie pliku *html* i całość zapisujemy do pliku *galeria.html*
