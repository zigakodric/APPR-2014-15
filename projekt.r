# 2. faza: Obdelava, uvoz in čiščenje podatkov
source("uvoz/uvoz.r",encoding="UTF-8")
source("lib/xml.r", encoding="UTF-8")
source("lib/uvozi.zemljevid.r", encoding="UTF-8")
source("slike/graf.r", encoding="UTF-8")

# 3. faza: Analiza in vizualizacija podatkov
source("vizualizacija/vizualizacija.r", encoding="UTF-8")

# 4. faza: Napredna analiza podatkov
source("analiza/analizaS.r", encoding="UTF-8")

cat("Končano.\n")
