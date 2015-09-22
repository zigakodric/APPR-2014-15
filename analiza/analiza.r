# 4. faza: Analiza podatkov
# # 4. faza: Analiza podatkov
# 
# # Uvozimo funkcijo za uvoz spletne strani.
# source("lib/xml.r")
# 
# # Preberemo spletno stran v razpredelnico.
# cat("Uvažam spletno stran...\n")
# tabela <- preuredi(uvozi.obcine(), obcine)
# 
# # Narišemo graf v datoteko PDF.
# cat("Rišem graf...\n")
# pdf("slike/naselja.pdf", width=6, height=4)
# plot(tabela[[1]], tabela[[4]],
#      main = "Število naselij glede na površino občine",
#      xlab = "Površina (km^2)",
#      ylab = "Št. naselij")
# dev.off()


#NAPOVED ZA SLOVENIJO
pdf("slike/napovedslo.pdf", width=6, height=4)
rast <- anapod$Rast
ststud <- anapod$Stevilo.studentov
plot(ststud, rast, xlab="Stevilo studentov", 
     ylab="Stopnja rasti",main="Napoved za Slovenijo",
     )
#Premica
lin <- lm(rast~ststud)
abline(lin, col="blue")
#Regresija
kv <- lm(rast ~ I(ststud^2) + ststud)
curve(predict(kv, data.frame(ststud=x)), add = TRUE, col = "red")
#Prileganje z zlepki
z <- lowess(ststud, rast)
points(z, col = "green", cex = 0.7)
lines(z, col = "green")
#loess
mls <- loess(rast ~ ststud)
curve(predict(mls, data.frame(ststud=x)), add = TRUE, col = "magenta")
#Legenda
legend("bottomright", c("Linerana metoda", "Kvadratna metoda","Prileganje z zlepki","Loess"),lty=c(1,1,1,1), col = c("blue","red","green", "magenta"), bg = "white", cex=0.9,)
dev.off()

#GRAF
pdf("slike/grana.pdf", width=6, height=4)
z<-anagrs[1:16, 2]
y<-anagrs[1:16, 3]
library(plotrix)
twoord.plot(anagrs[1:16, 1], z, anagrs[1:16, 1], y, type = "l", xlab="Leto",
            ylab="Rast BDP-ja", rylab="Stevilo studentov v tisocih",
            main="Rast BDP-ja in stevilo studentov", lcol="lightblue", rcol="blue")

dev.off()


#NAPOVED ZA ZDA
pdf("slike/napovedzda.pdf", width=6, height=4)
rastzda <- anazda$RastZDA
ststudzda <- anazda$Stevilo.studentov.ZDA
plot(ststudzda, rastzda, xlab="Stevilo studentov v stotisocih", 
     ylab="Stopnja rasti", main="Napoved za ZDA",
)
#Premica
lin <- lm(rastzda~ststudzda)
abline(lin, col="blue")
#Regresija
kv <- lm(rastzda ~ I(ststudzda^2) + ststudzda)
curve(predict(kv, data.frame(ststudzda=x)), add = TRUE, col = "red")
#Prileganje z zlepki
z <- lowess(ststudzda, rastzda)
points(z, col = "green", cex = 0.7)
lines(z, col = "green")
#loess
mls <- loess(rastzda ~ ststudzda)
curve(predict(mls, data.frame(ststudzda=x)), add = TRUE, col = "magenta")
#Legenda
legend("bottomright", c("Linerana metoda", "Kvadratna metoda","Prileganje z zlepki","Loess"),lty=c(1,1,1,1), col = c("blue","red","green", "magenta"), bg = "white", cex=0.9,)
dev.off()

#GRAF ZDA
pdf("slike/granazda.pdf", width=6, height=4)
z<-anagrzda[1:27, 2]
y<-anagrzda[1:27, 3]
library(plotrix)
twoord.plot(anagrzda[1:27, 1], z, anagrzda[1:27, 1], y, type = "l", xlab="Leto",
            ylab="Rast BDP-ja", rylab="Stevilo studentov v stotisocih",
            main="Rast BDP-ja in stevilo studentov", lcol="lightblue", rcol="blue")

dev.off()

#Metoda voditeljev
pdf("slike/celsvet.pdf", width=6, height=4)
imf <- read.csv("podatki/svet.csv", row.names = 1, fileEncoding = "UTF-8", dec=".")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/50m/cultural/ne_50m_admin_0_countries.zip",
                        "svet", "ne_50m_admin_0_countries.shp", mapa = "zemljevid", encoding = "Windows-1252")
imf[,"X.1"] <-as.numeric(as.character(imf[,"X.1"]))
imf[,"X.2"] <-as.numeric(as.character(imf[,"X.2"]))
imf[,"X.3"] <-as.numeric(as.character(imf[,"X.3"]))
imf[,"X.4"] <-as.numeric(as.character(imf[,"X.4"]))
imf[,"X.5"] <-as.numeric(as.character(imf[,"X.5"]))
imf[,"X.6"] <-as.numeric(as.character(imf[,"X.6"]))
imf[,"X.7"] <-as.numeric(as.character(imf[,"X.7"]))
imf[,"X.8"] <-as.numeric(as.character(imf[,"X.8"]))
imf[,"X.9"] <-as.numeric(as.character(imf[,"X.9"]))
imf[,"X.10"] <-as.numeric(as.character(imf[,"X.10"]))
imf.norm <- scale(imf)
k <- kmeans(imf.norm, 5)
head(k$cluster, n = 15)
table(k$cluster)
View(k$centers)
k <- kmeans(imf.norm, 5)
k$tot.withinss   
k <- kmeans(imf.norm, 5, nstart = 1000)
k$tot.withinss
drzave <- row.names(imf)
m <- match(svet$name_long, drzave)
barve <- rainbow(5)
plot(svet, col = ifelse(is.na(m), "grey", barve[k$cluster[drzave[m]]]))
dev.off()
