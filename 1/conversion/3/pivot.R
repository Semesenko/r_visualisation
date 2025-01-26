library(tidyr)
library(dplyr)# Завантаження пакетів
data <- read.csv("vegetation_plots.csv", header = TRUE) # Завантаження даних


long_data <- data %>%# Перетворення у довгий формат
  pivot_longer(
    cols = starts_with("Plot_"),  # Усі колонки, окрім 'plot', перетворюються у довгий формат
    names_to = "plot",
    values_to = "abundance"
  )


bb_to_percent <- function(abundance) { # Перетворення чисельності за шкалою Браун-Бланке на відсоткові значення
  case_when(
    abundance == "." ~ 0,
    abundance == "5" ~ 88,
    abundance == "4" ~ 67,
    abundance == "3" ~ 38,
    abundance == "2" ~ 13,
    abundance == "1" ~ 3,
    abundance == "+" ~ 2,
    abundance == "r" ~ 1,
    TRUE ~ NA_real_  # Обробка випадків, які не входять до шкали
  )
}

long_data <- long_data %>%
  mutate(abundance = bb_to_percent(abundance)) %>%
  filter(abundance > 0)  # Видалення рядків з нульовою чисельністю
write.csv(long_data, "vegetation_long_format.csv", row.names = FALSE)
