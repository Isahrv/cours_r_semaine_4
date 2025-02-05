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

library(dplyr)
library(stringr)

var_d9_d1 <- df_DEC_COM_Meta |>
  filter(str_detect(LIB_VAR_LONG, regex("Rapport interdécile D9/D1", ignore_case = TRUE)))

print(var_d9_d1)

cod_d9_d1 <- var_d9_d1$COD_VAR[1]

d9_d1_par_dept <- df_DEC_COM |>
  select(COD_VAR, !!sym(cod_d9_d1)) |>
  rename(Rapport_D9_D1 = !!sym(cod_d9_d1)) |>
  group_by(COD_VAR) |>
  summarise(Rapport_D9_D1 = mean(Rapport_D9_D1, na.rm = TRUE), .groups = "drop")

dept_min <- d9_d1_par_dept |> slice(which.min(Rapport_D9_D1))
dept_max <- d9_d1_par_dept |> slice(which.max(Rapport_D9_D1))

print(paste("Département avec le plus faible D9/D1 :", dept_min$COD_VAR, "(", dept_min$Rapport_D9_D1, ")"))
print(paste("Département avec le plus élevé D9/D1 :", dept_max$COD_DEP, "(", dept_max$Rapport_D9_D1, ")"))

#????

# Question 5
head(df_DEC_COM)
# Ce dataframe semble contenir des caractéristiques socio-économiques (comme l'age par ex) des personnes par code géographique.
# "s" veut peut-être dire que les informations manquent

# Question 6
library(dplyr)

DEC_COM_2 <- df_DEC_COM |>
  filter(CODGEO %in% c("44109", "97416"))|>
  mutate_all(~ gsub(",", ".", ., fixed = TRUE))|>
  mutate_all(as.numeric)
