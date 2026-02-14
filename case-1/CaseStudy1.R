# Problem 1
install.packages("readxl")
library(readxl)
data <- read_xlsx("CA_Schools_EE14/CASchools_EE141_InSample.xlsx")
str(data)
CAschool <- subset(data, charter_s == 0)

cor(CAschool$testscore, CAschool$med_income_z)
cor(CAschool$testscore, CAschool$str_s)

# Problem 2
hist(CAschool$testscore,
     main="Histogram of testscores",
     xlab="Testscore",
     col="lightblue")

minTestscore <- CAschool[which.min(CAschool$testscore), ] # Westmorland Elementary
maxTestscore <- CAschool[which.max(CAschool$testscore), ] # Tom Matsumoto Elementary

minTestscore$te_salary_avg_d # 59715
minTestscore$str_s # 15.82609
minTestscore$med_income_z # 15000

maxTestscore$te_salary_avg_d # 80971
maxTestscore$str_s # 25.35294
maxTestscore$med_income_z # 51556



quantiles <- quantile(CAschool$str_s, probs=seq(0,1,0.2))
group_strs <- ifelse(CAschool$str_s < quantiles[2], -1, 
                     ifelse(CAschool$str_s > quantiles[5], 1, 0 ))
CAschool$group_strs <- group_strs

CAschool$str_s

boxplot(testscore ~ group_strs, data = CAschool,
        names = c("Low STR\n(-1)", "Medium STR\n(0)", "High STR\n(1)"),
        main = "Test Scores by Student-Teacher Ratio Groups",
        ylab = "Test Scores",
        col = c("lightblue", "lightgreen", "lightcoral"),
        las = 1)

CAschool$lmed_income <- log(CAschool$med_income_z) 
plot(CAschool$lmed_income,CAschool$testscore,type="p", main="Testscore by Log(Median Income)",
     ylab="Test Scores",
     xlab="Log(Median Income Z-Score)",
     pch=16,
     col="darkblue",
     cex=0.8)
# x = 10 ~ 750 ; x = 11 ~ 900 ; b = 150 ; a = -750
abline(a=-750, b=150, col="red",lwd=5)

# Problem 5
reg1 <- lm(testscore ~ log(med_income_z), data=CAschool)
reg1
abline(reg1,col="blue",lwd=5)
log(22026.47)
# ~ 710
# f(10) = 112.8 * log10 - 396.8 = 731.2
?predict
log(22026.47)
predict(reg1, newdata=data.frame(med_income_z=c(22026.47)))
predict(reg1, newdata=data.frame(med_income_z=c(22026.47 * exp(-0.5))))


residuals <- resid(reg1)
plot(CAschool$lmed_income, residuals, 
     xlab = "lmed_income", 
     ylab = "Residuals", 
     main = "Residuals vs lmed_income")
abline(h=0, col="red", lwd=3)

plot(reg1, which = 1)

reg2 <- lm(log(testscore) ~ log(med_income_z), data=CAschool)
residuals <- resid(reg2)
plot(CAschool$lmed_income, residuals, 
     xlab = "lmed_income", 
     ylab = "Residuals", 
     main = "Residuals vs lmed_income")
abline(h=0, col="red", lwd=3)   
plot(reg2, which = 1)                                    
