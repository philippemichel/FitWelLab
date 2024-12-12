

#  ------------------------------------------------------------------------
#
# Title : import fitw
#    By : PhM
#  Date : 2024-11-28
#
#  ------------------------------------------------------------------------



library(tidyverse)
library(readODS)
library(labelled)

# Import data
tt <- read_ods("datas/fitweb.ods", sheet = 1) |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(age = 2024-anne_naissance) |>
mutate(trajet = fct_relevel(trajet,
    "Moins de 10 min", "Entre 11 et 20 min", "Entre 21 et 30 min",
    "Entre 31 et 45 min", "Plus de 45 min"
  )) |>
mutate(across(ends_with("h_j"), ~ as.numeric(hms(.x))/60)) |>
mutate(temps_assis =  as.numeric(hms(temps_assis))/60)

bnom <- c("ID","Année de naissance","Sexe","Temps de trajet","Raison de l'adhésion","Activités intenses","Activités intenses","Activités modérées","Activités modérées","Marche","Marche","Temps assis","Âge")

var_label(tt) <- bnom
#
save(tt,file = "datas/fitw.RData")
load("datas/fitw.RData")


tt0 <- read_ods("datas/M0.ods", sheet = 1) |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(temps = "M0")

tt3 <- read_ods("datas/M3.ods", sheet = 1) |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(temps = "M3")

tt7 <- read_ods("datas/M7.ods", sheet = 1) |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(temps = "M7")
#
#---------------------------------
#

lyk <- function(df, n1,n2, lv){
  df <- df |>
    mutate(across(n1:n2, ~ factor(.x, levels = lv))) |>
    mutate(across(n1:n2, ~ fct_relevel(.x,lv)))
  return(df)
}
#
#---------------------------------
#
lv1 <- c("très bon(ne)", "bon(ne)", "ni bon(ne), ni mauvais(e)","mauvais(e)")
lv2 <- c("tous les jours ou presque", "1 ou 2 fois par semaine", "1 ou 2 fois par mois", "1 ou 2 fois depuis 6 mois", "jamais depuis 6 mois")
lv3 <- c("en permanence", "souvent", "parfois", "rarement", "jamais")
lv4 <- c("très dur", "dur", "ni facile, ni dur","facile", "très facile")
lv5 <- c("largement insuffisantes", "plutôt insuffisantes", "adaptées", "plus importantes que nécessaire", "largement plus importantes que nécessaire")
lv6 <- c("me contrarie fortement", "ne me convient pas" , "je fais avec", "me convient", "contribue à mon épanouissement")
lv7 <- c("non", "pas du tout", "plutôt non", "ni oui", "ni non", "plutôt oui", "oui, tout à fait")
lvf <- c("Très satisfait(e)", "Plutôt satisfait(e)", "Plutôt insatisfait(e)", "Très insatisfait(e)")
satin <-  rbind(tt0,tt3)
satin <- rbind(satin,tt7) |>
lyk(n1 = 13, n2 = 16, lv = lv1) |>
lyk(n1 = 18, n2 = 25, lv = lv2) |>
lyk(n1 = 26, n2 = 28, lv = lv3) |>
lyk(n1 = 29, n2 = 32, lv = lv4) |>
lyk(n1 = 33, n2 = 36, lv = lv5) |>
lyk(n1 = 37, n2 = 75, lv = lv6) |>
lyk(n1 = 76, n2 = 77, lv = lv7)
#
#---------------------------------
#

final <- read_ods("datas/final.ods", sheet = 1) |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  lyk(n1 = 3, n2 = 14, lv = lvf)

save(tt, satin,final, file = "datas/fitw.RData")
load("datas/fitw.RData")
