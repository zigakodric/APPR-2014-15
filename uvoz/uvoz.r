# 2. faza: Uvoz podatkov
uvoziPodatke <- function() {
  return(read.table("podatki/podatki.csv", sep = ",", as.is = TRUE, na.strings = "..",
                    col.names = c("x", "x", "Country Name", "x", "School enrollment,tertiary (% gross)", "Expenditure per student, primary (%of GDP per capita)", "Expenditure per student,secondary (% of GDP per capita)", "Expenditure per student, tertiary (% of GDP per capita)", "Public spending on education, total (% of government expenditure)", "Labor force with primary education (% of total)", "Labor force with secondary education (% of total)", "Labor force with tertiary education (% of total)", "Labor force, total", "Unemployment,total (% of total labor force)", "Population ages 0-14 (% of total)", "Population ages 15-64 (% of total)", " Literacy rate, youth total(% of people ages 15-24)", "Literacy rate, adult total (% of people ages 15 and above)", "School enrollment, preprimary (% gross)", "Primary school starting age (years)", "Primary completion rate, total (% of relevant age group)", "Primary education, duration (years)", "School enrollment, primary (% gross)", "Gross intake ratio in first grade of primary education, total (% of relevant age group)", "School enrollment, primary (% net)", "School enrollment, primary, private (%
of total primary)", "Trained teachers in primary education (% of total teachers)", "Primary education, teachers", "Children out of school, primary", "Secondary school starting age (years)", "Secondary education, duration (years)", "School enrollment, secondary (% gross)",
                                  " School enrollment, secondary, private (% of total secondary)", "Progression to secondary school (%)", "Repeaters, secondary, total (% of total enrollment)", "Secondary education, teachers" ),
                    fileEncoding = "Windows-1250"))
}
cat("Uvažam podatke o izobraževanju...\n")
Tabela <- uvoziPodatke()
Tabela[,"x"] <- NULL
Tabela[, "x.1"] <- NULL
Tabela[, "x.2"] <- NULL

#Uvoz podatkov za zemlejvid

uvoziregije <- function() {
  return(read.csv("podatki/regije.csv", sep = ";", as.is = TRUE, encoding = "UTF-8" ,
                  row.names = 1, na.strings=c("-", "z"),
                  fileEncoding = "Windows-1250"))
}
regije <- uvoziregije()


