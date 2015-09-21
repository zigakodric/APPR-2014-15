# Graf
# Graf ZDA
pdf("slike/grafzda.pdf", width=6, height=4)
Leto <- TabelaGraf[, "x.2"]
Št_študentovZDA <- TabelaGraf[, "x.4"]
plot(Leto, Št_študentovZDA, xlab = "Leto", ylab = "Število študentov", type = "l", main = "Število študentov v ZDA", cex = 0.5)
dev.off()

#Graf Kitajska
pdf("slike/grafKit.pdf", width=6, height=4)
LetoKit <- TabelaGrafKit[, "x.2"]
Št_študentovKit <- TabelaGrafKit[, "x.4"]
plot(LetoKit, Št_študentovKit, xlab = "Leto", ylab = "Število študentov", type = "l", main = "Število študentov na Kitajskem", cex = 0.5)
dev.off()
