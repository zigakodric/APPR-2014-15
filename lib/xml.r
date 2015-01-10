# Uvoz s spletne strani
library(XML)
# Vrne vektor nizov z odstranjenimi začetnimi in končnimi "prazninami" (whitespace)
# iz vozlišč, ki ustrezajo podani poti.
stripByPath <- function(x, path) {
  unlist(xpathApply(x, path,
                    function(y) gsub("^\\s*(.*?)\\s*$", "\\1",
                                     gsub("[^[:alnum:] (),]", "",
                                          xmlValue(y)))))
}
uvozi.evropa <- function() {
  url.evropa <- "http://ec.europa.eu/eurostat/tgm/table.do?tab=table&init=1&language=en&pcode=tsdsc410&plugin=1"
  con <- url(url.evropa)
  doc.evropa <- htmlTreeParse(readLines(con), useInternalNodes=TRUE)
  close(con)
  # Poiščemo vse tabele v dokumentu
  tabele <- getNodeSet(doc.evropa, "//table")
  # Iz druge tabele dobimo seznam vrstic (<tr>) neposredno pod
  # trenutnim vozliščem
  vrstice <- getNodeSet(tabele[[6]], ".//tr")
  # Seznam vrstic pretvorimo v seznam (znakovnih) vektorjev
  # s porezanimi vsebinami celic (<td>) neposredno pod trenutnim vozliščem
  seznam <- lapply(vrstice, stripByPath, "./td/div")
  # Iz seznama vrstic naredimo matriko
  matrika <- matrix(unlist(seznam), nrow=length(seznam), byrow=TRUE)
  # Imena stolpcev matrike dobimo iz celic (<th>) glave (prve vrstice) prve tabele
  colnames(matrika) <- gsub("\n", " ", stripByPath(tabele[[4]], ".//th/div"))
  imena <- gsub("\n", " ", stripByPath(tabele[[5]], ".//th"))
  # Podatke iz matrike spravimo v razpredelnico
  return(
    data.frame(apply(gsub("[^0-9]", "", matrika),
                     2, as.numeric), row.names = imena)
  )
}

evropa <- uvozi.evropa()
