install.packages("tree")

library(rpart)
library(tree)
library(party)

names(d)

# Set up formula: Quintile depends on Diabetes, Inactivity

formula = d$Quintiles ~ d$ageadjustedpercent2004diabetes + d$ageadjustedpercentleisuretimephysicalinactivityprevalence2004 +
                        d$unemploymentRate + d$educationHighSchoolOrAboveRate + d$perCapitaPersonalIncome +
                        d$AvgDailyMinAirTemperatureF + d$AvgDailyMaxHeatIndexF

# first option - rpart

fit = rpart(formula = formula, data = d, method = "class")

printcp(fit)
plotcp(fit)
summary(fit)

plot(fit, uniform=TRUE, main="Classification Tree for CVD")
text(fit, use.n=TRUE, all=TRUE, cex=.8)

# second option - tree

tr = tree(formula, data=d)

summary(tr)

plot(tr)

text(tr)

# third option - party

(ct = ctree(formula, data = d))
plot(ct, main="Decision Tree")

#Table of prediction errors
table(predict(ct), d$quintile)

# Estimated class probabilities
tr.pred = predict(ct, newdata=raw, type="prob")

