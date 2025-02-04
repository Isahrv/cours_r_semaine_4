# Question 2

library(jsonlite)
df_DEC_DEP <- read_json("C:/Users/isali/OneDrive/Documents/cours/M1 ECAP/S2/RShiny & Dataviz/cours_r_semaine_4/data/DEC_DEP.json")

library(arrow)
df_DEC_DEP_Meta <- read_parquet("C:/Users/isali/OneDrive/Documents/cours/M1 ECAP/S2/RShiny & Dataviz/cours_r_semaine_4/data/DEC_DEP_Meta.parquet")

library(DBI)
library(RSQLite)
conn <- dbConnect(RSQLite::SQLite(), dbname = "data/DEC_COM.sqlite")
dbListTables(conn)
df_DEC_COM <- dbReadTable(conn = conn, name = "DEC_COM")

df_DEC_COM_Meta <- read_parquet("C:/Users/isali/OneDrive/Documents/cours/M1 ECAP/S2/RShiny & Dataviz/cours_r_semaine_4/data/DEC_COM_Meta.parquet")
