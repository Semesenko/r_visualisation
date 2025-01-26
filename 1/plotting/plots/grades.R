install.packages("tidyr")
install.packages("dplyr")
install.packages("ggplot2")
library(tidyr)
library(dplyr)
library(ggplot2)
data <- read.csv("grades.csv")
data <- separate(data, semester..grades, into = c("semester", "grades"), sep = ";")
data$semester <- as.numeric(data$semester)
data$grades <- as.numeric(data$grades)
new_grades <- c(100, 72, 70, 66, 94, 65, 85, 85, 86, 50, 85, 60, 66, 91)
data$grades <- new_grades
summary(data$grades) 
mean(data$grades)     
median(data$grades)   
grouped_stats <- data %>% 
  group_by(semester) %>%
  summarize(
    Mean = mean(grades, na.rm = TRUE),
    Median = median(grades, na.rm = TRUE),
  )
print(grouped_stats)
ggplot(data, aes(x = factor(semester), y = grades)) + #помилку яку я робив не додавав factor, завдяки цьому визначаб оцінку за перший семестр як окрему категорію
  geom_boxplot(fill = "red", color = "blue") +
  labs(title = "Оцінки за перший рік", x = "Семестр", y = "Оцінки") +
  theme_minimal()
cor(data$semester, data$grades)  
anova_result <- aov(grades ~ as.factor(semester), data = data)
summary(anova_result) 


