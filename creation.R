# création d'un fichier test

lik <- c("Très satisfait(e)","Plutôt satisfait(e)","Ni satisfait(e) ni insatisfait(e)","Plutôt insatisfait(e)", "Très insatisfait(e)")
library(tidyverse)
library(gtsummary)
library(colorspace)



zz1 <- factor(round(runif(100,1,5),0), labels = lik)
zz2 <- factor(round(runif(100,1,5),0), labels = lik)
zz3 <- factor(round(runif(100,1,5),0), labels = lik)
zz4 <- factor(round(runif(100,1,5),0), labels = lik)
zz5 <- factor(round(runif(100,1,5),0), labels = lik)
zz6 <- factor(round(runif(100,1,5),0), labels = lik)


noms <- c("jours", "horaires", "types", "fréquence", "acessibilité", "diversité")


tt <- tibble(zz1,zz2,zz3,zz4,zz5,zz6)
names(tt) <- noms
write.csv(tt, "test.csv")
