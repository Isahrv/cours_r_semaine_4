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
head(df_DEC_COM_Meta)

# Question 3
## Moins de 30 ans
library(dplyr)
library(stringr)
moins_30 <- df_DEC_COM_Meta |>
  filter(str_detect(LIB_VAR_LONG, regex("moins de 30", ignore_case = TRUE)))

nrow(moins_30)

couples_enfants <- df_DEC_COM_Meta |>
  filter(str_detect(LIB_VAR_LONG, regex("couples avec enfant", ignore_case = TRUE)))

nrow(couples_enfants)

indice_gini <- df_DEC_COM_Meta |>
  filter(str_detect(LIB_VAR_LONG, regex("Indice de Gini", ignore_case = TRUE))) |>
  select(COD_VAR)

print(indice_gini)

# Question 4
