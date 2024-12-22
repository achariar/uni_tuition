library(readxl)
library(ggplot2)

uni <- read_excel("uni.xlsx")

uni <- subset(uni, Grad.Rate > 50)

uni <- na.omit(uni)

uni$Apps <- as.numeric(uni$Apps)
uni$Accept <- as.numeric(uni$Accept)
uni$F.Undergrad <- as.numeric(uni$F.Undergrad)
uni$Outstate <- as.numeric(uni$Outstate)
uni$Expend <- as.numeric(uni$Expend)
uni$App.Rate <- uni$Accept / uni$Apps

model <- lm(Outstate ~ App.Rate + Private + Expend + Grad.Rate + S.F.Ratio + Private:Expend, data = uni)

summary(model)

ggplot(uni, aes(x = App.Rate, y = Outstate, color = Private)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Effect of Acceptance Rate and Private/Public Status on Tuition",
    x = "Acceptance Rate",
    y = "Tuition (Outstate)"
  ) +
  theme_minimal()

uni$University <- as.character(uni$University)

ggplot(uni, aes(x = App.Rate, y = Outstate, color = Private)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Effect of Acceptance Rate and Private/Public Status on Tuition",
    x = "Acceptance Rate",
    y = "Tuition (Outstate)"
  ) +
  theme_minimal() +
  geom_text(
    data = subset(uni, University %in% c("University of Michigan at Ann Arbor", "Colorado State University", "Yale University", "Oberlin College")),
    aes(label = University),
    nudge_y = 500,
    check_overlap = TRUE,
    size = 3
  )

