# Problem 1
library(readxl)
data <- read_xlsx("Birthweight_Smoking/birthweight_smoking.xlsx")
str(data)
data<- data[, c('birthweight', 'age', 'educ', 'drinks', 'smoker', 'tripre0')]

# Russell, C. S., Taylor, R., & Law, C. E. (1968). Smoking in pregnancy, maternal blood pressure, pregnancy outcome, baby weight and growth, and other related factors. A prospective study. British journal of preventive & social medicine, 22(3), 119.
# https://link.springer.com/article/10.1186/s12884-018-1694-4

# Rous, J. J., Jewell, R. T., & Brown, R. W. (2004). The effect of prenatal care on birthweight: a full‐information maximum likelihood approach. Health economics, 13(3), 251-264.
# https://onlinelibrary.wiley.com/doi/epdf/10.1002/hec.801

# Restrepo‐Méndez, M. C., Lawlor, D. A., Horta, B. L., Matijasevich, A., Santos, I. S., Menezes, A. M., ... & Victora, C. G. (2015). The association of maternal age with birthweight and gestational age: a cross‐cohort comparison. Paediatric and perinatal epidemiology, 29(1), 31-40
# https://onlinelibrary.wiley.com/doi/full/10.1111/ppe.12162


cor(data$birthweight, data$smoker)
cor(data$birthweight, data$tripre0)
cor(data$birthweight, data$age)

# Problem 2
library(ggplot2)
ggplot(data, aes(x = birthweight, color = factor(smoker))) +
  geom_density(linewidth = 1.2) +
  labs(
    title = "Density of Birthweight by Smoking Status",
    x = "Birthweight (grams)",
    y = "Density",
    color = "Smoker") +     theme_minimal()

ggplot(data, aes(x = birthweight, color = factor(tripre0))) +
  geom_density(linewidth = 1.2) +
  labs(
    title = "Density of Birthweight by Prenatal Visit (tripre0)",
    x = "Birthweight (grams)",
    y = "Density",
    color = "No Prenatal Visit"
  ) +
  theme_minimal()

# Problem 3
# Problem 3.1
linear_model <- lm(birthweight ~ age + educ + drinks + smoker + tripre0, data=data)
beta_age <- coef(linear_model)["age"]
2*beta_age

beta_smoker <- coef(linear_model)["smoker"]
beta_smoker

# Problem 3.2
summary(linear_model)

linear_model_excluding_smoker <- lm(birthweight ~ age + educ + drinks + tripre0, data=data)
summary(linear_model_excluding_smoker)

model_plus <- linear_model

coef(model_plus)["tripre0"]

# Problem 3.3
SSR <- sum(resid(model_plus)^2)
degrees_of_freedom <- model_plus$df.residual
sigma2hat <- SSR / degrees_of_freedom
sigma2hat

X <- cbind(1, data$age, data$educ, data$drinks, data$smoker, data$tripre0)
Xt_X <- t(X) %*% X
vcov_matrix <- sigma2hat * solve(Xt_X)
vcov_matrix[3,6]

# Problem 4
alpha <- 0.05
c_alpha <- 1-alpha/ 2
critical_value <- qt(c_alpha,df=degrees_of_freedom)
t_drinks <- coef(summary(model_plus))[, "t value"]["drinks"]
if(abs(t_drinks) <= critical_value){
  print("Do not reject H0 as the t-statistic is smaller than or equal to the critical value")
} else{
  print("Reject H0 as the t-statistic is greater than the critical value")
}

p_drinks <- coef(summary(model_plus))[, "Pr(>|t|)"]["drinks"]
if(p_drinks < alpha){
  print("Reject H0 as the p-value is smaller than the significance level")
} else{
  print("Do not reject H0 as the p-value is greater than or equal to the significance level")
}

t_tripre0 <- coef(summary(model_plus))[, "t value"]["tripre0"]
if(abs(t_tripre0) <= critical_value){
  print("Do not reject H0 as the t-statistic is smaller than or equal to the critical value")
} else{
  print("Reject H0 as the t-statistic is greater than the critical value")
}

p_tripre0 <- coef(summary(model_plus))[, "Pr(>|t|)"]["tripre0"]
if(p_tripre0 < alpha){
  print("Reject H0 as the p-value is smaller than the significance level")
} else{
  print("Do not reject H0 as the p-value is greater than or equal to the significance level")
}

critical_value <- qt(c_alpha, df = degrees_of_freedom)
se_tripre0 <- vcov_matrix[6,6]
t_tripre0 <- (coef(model_plus)["tripre0"]-1) / sqrt(se_tripre0)
if(abs(t_tripre0) <= critical_value){
  print("Do not reject H0 as the t-statistic is smaller than or equal to the critical value")
} else{
  print("Reject H0 as the t-statistic is greater than the critical value")
}

p_tripre0 <- 2 * (1 - pt(abs(t_tripre0), degrees_of_freedom))
print(p_tripre0)
if(p_tripre0 < alpha){
  print("Reject H0 as the p-value is smaller than the significance level")
} else{
  print("Do not reject H0 as the p-value is greater than or equal to the significance level")
}

newdata <- data.frame(
  age = 28,
  educ = 12,
  drinks = 2,
  smoker = 1,
  tripre0 = 1
)
predicted_bw <- predict(model_plus, newdata = newdata)
predicted_bw

