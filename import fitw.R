

#  ------------------------------------------------------------------------
#
# Title : import fitw
#    By : PhM
#  Date : 2024-11-28
#
#  ------------------------------------------------------------------------



library(tidyverse)
library(readODS)

# Import data
tt <- read_ods("datas/fitweb.ods", sheet = 1) |>
  janitor::clean_names() |>
  mutate(across(where(is.character), as.factor)) |>
  mutate(age = 2024-anne_naissance) |>
mutate(trajet = fct_relevel(trajet,
    "Moins de 10 min", "Entre 11 et 20 min", "Entre 21 et 30 min",
    "Entre 31 et 45 min", "Plus de 45 min"
  ))

#
save(tt, file = "datas/fitw.RData")
tt <- load("datas/fitw.RData")
