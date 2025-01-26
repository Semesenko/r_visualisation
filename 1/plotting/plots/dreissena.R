install.packages(c('ggplot2','gganimate', 'gifski'))
library(ggplot2)
library(gganimate)
dreissena <- read.csv("dreissena_raw.csv") #конвертуємо дані
dreissena$Infection <- as.numeric(as.character(dreissena$Infection)) # навсяк випадок конфертуємо всі інфекції в числове значення, щоб прибрати на
dreissena <- dreissena[!is.na(dreissena$Infection), ] # Rвидаляємо на точно усі на значення з інфекцій
dreissena$Month <- factor(dreissena$Month, levels = c("May", "July", "September"))#створюємо порядок за місяцями
dreissena$Month_numeric <- as.numeric(dreissena$Month)#робимо місяці числовим значенням, щоб можна було зробити анімований графік
Month.colour <- c( #до кожного місяця призначаємо кольор
  "May" = "blue",
  "July" = "green",
  "September" = "red"
)
p1 <- ggplot(dreissena, aes(x = Infection, y = Length, colour = Month))+ #додаємо за якими значеннями будемо робити осі координат і абсцис 
  geom_point(alpha = 0.7, show.legend = F)+
  scale_colour_manual(values = Month.colour)+
  scale_size(range=c(2,12))+
  scale_x_log10()+
  facet_wrap(~Lake)+ #ділимо наші значення за озерами, тобто юуже три плота з озерами
  labs(title = 'Статистика популяцій Дрейсен', x='Інфековані', y = 'Довжина')+
  transition_time(Month_numeric)+ #за якими значеннями анімуємо, тобто в нашому випадку це місяці
  ease_aes('linear') #прошу робити перехід плавно
animated_plot <- animate(p1, renderer = gifski_renderer()) #задаємо що анімувати
anim_save("dreissena_animation.gif", animation = animated_plot)

