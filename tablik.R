# ÉCRITURE D'UN TABLEAU & GRAPHIQUES LIKERT

library(tidyverse)
library(gtsummary)
library(colorspace)
library(baseph)

tablik <- function(dfx, col, titre = "", expx = FALSE, classeur = "",nomfich = "") {
tabz <-   dfx |>
    pivot_longer(col)

tabz |>
    tbl_cross(
      name,
      value,
      percent = "row",
      margin = "row",
      label = name ~ "items"
    ) |>
    modify_header(label ~ " ") |>
    modify_spanning_header(paste0("stat_", 1:5) ~ "Réponse") |>
    modify_caption(titre) |>
    bold_labels() |>
    gexptabph(
      lg = FALSE,
      exp = expx,
      nomfich = classeur,
      nomsheet = nomfich
    ) |>
print()

tabz |>
  #  mutate(value = fct_relevel(value, c("À la folie","Beaucoup", "Un peu","Pas du tout"))) |>
  ggplot() +
  aes(x = name, fill = value) +
  geom_bar(stat = "count", position = "fill") +
  scale_fill_discrete_sequential(palette = "Inferno") +
  theme_light() +
  labs(
    title = titre,
    subtitle = "",
    y = "%",
    fill = "Réponse",
    caption = titre
  ) +
  theme(
    plot.title = element_text(size = 18, face = "bold"),
    plot.subtitle = element_text(size = 12),
    axis.title.y = element_text(
      size = 12,
      angle = 90,
      vjust = .5
    ),
    axis.title.x = element_blank(),
    axis.text.x = element_text(
      size = 12,
      angle = 20,
      hjust = 0.5,
      vjust = 0.6
    ),
    axis.text.y = element_text(size = 12),
    legend.position = "right"
  )

}
