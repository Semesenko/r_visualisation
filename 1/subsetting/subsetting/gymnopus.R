rm(list = ls())
setwd("C:/R_codes/r_visualisation/1/subsetting/subsetting")
library(tidyverse)
library(conflicted)


conflicts_prefer(dplyr::filter)

`%notin%` <- Negate(`%in%`)

fungi <- read.csv("fungi_occurrences.csv")

gymnopus <- fungi %>%
  filter(genus == "Gymnopus") %>%  # No ambiguity now
  mutate(date = as.Date(date)) %>%
  mutate(month = months(date)) %>%
  filter(month %in% c("червень", "липень", "серпень")) %>%
  filter(name %notin% c("Gymnopus sp.", "Gymnopus peronatus", "Gymnopus confluens")) %>%
  count(ecol) %>%
  rename(num_occurrences = n) %>%
  arrange(desc(num_occurrences))

print(gymnopus)
