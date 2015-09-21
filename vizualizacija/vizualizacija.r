# Uvozimo funkcijo za pobiranje in uvoz zemljevida.
source("lib/uvozi.zemljevid.r")
gpclibPermit()

# Funkcija, ki podatke preuredi glede na vrstni red v zemljevidu
preuredi <- function(podatki, zemljevid) {
  nove.slo <- c()
  manjkajo <- ! nove.slo %in% rownames(podatki)
  M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(podatki)))
  names(M) <- names(podatki)
  row.names(M) <- nove.slo[manjkajo]
  podatki <- rbind(podatki, M)
  out <- data.frame(podatki[order(rownames(podatki)), ])[rank(levels(zemljevid$NAME_1)[rank(zemljevid$NAME_1)]), ]
  if (ncol(podatki) == 1) {
    out <- data.frame(out)
    names(out) <- names(podatki)
    rownames(out) <- rownames(podatki)
  }
  return(out)
}



# 1ZEMLJEVID Evropa
# Uvozimo zemljevid.
cat("Uvažam zemljevid sveta...\n")
svet <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                        "Europa", "ne_110m_admin_0_countries.shp", mapa = "zemljevid",
                        encoding = "Windows-1250")



manjkajoce.drzave <- c() 
drzave <- c(rownames(evropa), manjkajoce.drzave)
drzave <- drzave[drzave %in% svet$name_long]
EU <- svet[svet$name_long %in% drzave,]

# Preuredimo podatke, da jih bomo lahko izrisali na zemljevid.

manjkajo <- ! manjkajoce.drzave %in% rownames(evropa)
M <- as.data.frame(matrix(nrow=sum(manjkajo), ncol=length(evropa)))
names(M) <- names(evropa)
row.names(M) <- manjkajoce.drzave[manjkajo]
eevropa <- rbind(evropa, M)[as.character(EU$name_long),]
koordinate <- coordinates(EU[!is.na(eevropa[, 12]),])
imena.drzav <- EU$name[!is.na(eevropa[, 12])]
rownames(koordinate) <- imena.drzav

koordinate["Norway",1] <- koordinate["Norway",1]-1.8
koordinate["Croatia", 2]<- koordinate["Croatia",2]+0.7
koordinate["Greece", 1]<- koordinate["Greece", 1]-0.4
koordinate["Sweden",1]<-koordinate["Sweden", 1]-1
pdf("slike/EU.pdf")
EU$eeevropa <- eevropa[, 12]
print(spplot(EU, "eeevropa", xlim=c(-25, 40), ylim=c(33, 73),
             main = "Early leavers from education and training",
             col.regions = topo.colors(100),
             sp.layout = (list(list("sp.text", koordinate, imena.drzav, cex = 0.4)))))
dev.off()

# 2 Zemljevid število študentov po slovenskih regijah v letih od 2002-2012

# Uvoz funkcije za zemljevid
source("lib/uvozi.zemljevid.r")
# Uvozimo zemljevid
cat("Uvažam zemljevid slovenije...\n")
slo <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2/shp/SVN_adm.zip",
                       "slovenija", "SVN_adm1.shp", mapa = "zemljevid",
                       encoding = "Windows-1250")

# Preuredimo podatke za izris na zemljevid
rregije <- preuredi(regije, slo)
# Narišimo zemljevid v PDF.
cat("Rišem zemljevid slovenije...\n")
pdf("slike/slovenija1.pdf")
#Spremenjene koordinate in imena za Slovenijo
koordinate1 <- coordinates(slo)
imena1 <- as.character(slo$NAME_1)
rownames(koordinate1) <- imena1
names(imena1) <- imena1
koordinate1["Obalno-kraška",1] <- koordinate1["Obalno-kraška",1]+0.1 #levo,desno
koordinate1["Obalno-kraška",2] <- koordinate1["Obalno-kraška",2]+0.025 #dol,gor
koordinate1["Zasavska",2] <- koordinate1["Zasavska",2]+0.01
koordinate1["Spodnjeposavska",1] <- koordinate1["Spodnjeposavska",1]+0.08
koordinate1["Spodnjeposavska",2] <- koordinate1["Spodnjeposavska",2]
imena1["Jugovzhodna Slovenija"] <- "Jugovzhodna\nSlovenija"
imena1["Notranjsko-kraška"] <- "Notranjsko-\nkraška"
imena1["Obalno-kraška"] <- "Obalno-\nkraška"


# 3 Primerjava med letoma 2002 in 2013
#2002
pdf("slike/stud2002.pdf")
slo$studenti2002 <- rregije[,1]
print(spplot(slo, "studenti2002", col.regions = topo.colors(50),
             main = "Število študentov po regijah (leto 2002)",
             sp.layout = list(list("sp.text", koordinate1,imena1, cex = 0.5))))
dev.off()

#2013
pdf("slike/stud2013.pdf")
slo$studneti2013 <- rregije[,11]
print(spplot(slo, "studneti2013", col.regions = topo.colors(50),
             main = "Število študentov po regijah (leto 2013)",
             sp.layout = list(list("sp.text", koordinate1,imena1, cex = 0.5))))
dev.off()
