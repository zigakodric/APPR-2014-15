# Graf
# Funkcija, ki uvozi podatke za graf in ukaz, ki graf nariše
pdf("slike/grafi.pdf", paper="a4r")
uvoziPodatkeGraf <- function() {
  return(read.table("podatki/grafzda.csv", sep = ",", as.is = TRUE,
                    
                    col.names = c("x","x", "x","x","x"),
                    fileEncoding = "Windows-1250"))
}

TabelaGraf <- uvoziPodatkeGraf()
Leto <- TabelaGraf[, "x.2"]
Št_študentovZDA <- TabelaGraf[, "x.4"]
plot(Leto, Št_študentovZDA, xlab = "Leto", ylab = "Število študentov", type = "l" main = "Število študentov v ZDA")
dev.off()
