# Analiza podatkov s programom R, 2014/15
## Raven izobraževanja po svetu

Avtor: Kodrič Žiga

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2014/15.

## Tematika

Za temo projekta sem si izbral raven izobraževanja po svetu. Namen imam analizirati vlaganje držav v izobraževanje, število vključenih otrok v izobraževalni sistem ipd. Analiziral bom tudi razlike med izobraževalnim sistemom v razvitih državah in državah tretjega sveta.

Podatke sm dobil na spletni strani svetovne banke. Na voljo so v .hmtl in cvs datotekah. Po potrebi bom poiskal še dodatne podatke.

Povezava do podatkov:
databank.worldbank.org/data/projekt/id/53771e2b

## Program

Glavni program se nahaja v datoteki `projekt.r`. Ko ga poženemo, se izvedejo
programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Slike, ki jih program naredi, se shranijo v mapo
`slike/`. Zemljevidi v obliki SHP, ki jih program pobere, se shranijo v mapo
`zemljevid/`.

## Poročilo

Poročilo se nahaja v mapi `porocilo/`. Za izdelavo poročila v obliki PDF je
potrebno datoteko `porocilo/porocilo.tex` prevesti z LaTeXom. Pred tem je
potrebno pognati program, saj so v poročilu vključene slike iz mape `slike/`.
