set.seed(1426)

library(rattle)
library(rpart)
library(rpart.plot)

data(weather)
dsname <- "weather"
ds <- get(dsname)
id <- c("Date", "Location")
target <- "RainTomorrow"
risk <- "RISK_MM"
ignore <- c(id, if (exists("risk")) risk) 
(vars <- setdiff(names(ds), ignore))

inputs <- setdiff(vars, target)
(nobs <- nrow(ds))

(numerics <- intersect(inputs, names(ds)[which(sapply(ds[vars], is.numeric))]))

(categorics <- intersect(inputs, names(ds)[which(sapply(ds[vars], is.factor))]))

(form <- formula(paste(target, "~ .")))

length(train <- sample(nobs, 0.7*nobs))

length(test <- setdiff(seq_len(nobs), train))

actual <- ds[test, target]
risks <- ds[test, risk]

dim(ds)

names(ds)

head(ds)

tail(ds)

str(ds)

summary(ds)

# build decision tree model

model <- rpart(formula=form, data=ds[train, vars])

model

summary(model)

# complexity parameter stored as model$cptable

printcp(model)

# complexity parameter plot
# plots cross-validation results

plotcp(model)

# complexity parameter with larger dataset

tmodel <- rpart(form, weatherAUS[vars])
plotcp(tmodel)

# set cp to 0 so no pruning is performed

tmodel <- rpart(form, weatherAUS[vars], control=rpart.control(cp=0))
plotcp(tmodel)

# view raw data - choose a sensible value of cp= from this table

tmodel$cptable[c(1:5, 22:29, 80:83),]

tmodel <- rpart(form, weatherAUS[vars], control=rpart.control(cp=0.00041074431))
plotcp(tmodel)

model$variable.importance

# risk chart

predicted <- predict(model, ds[test, vars], type="prob")[,2]

riskchart(predicted, actual, risks)

# error matrix

predicted <- predict(model, ds[test, vars], type="class")
sum(actual != predicted)/length(predicted) # Overall error rate

round(100*table(actual, predicted, dnn=c("Actual", "Predicted"))/length(predicted))

# print the paths through the tree as rules.

asRules.part <- function(model)
{
  if (!inherits(model, "rpart")) stop("Not a legitimate rpart tree")
  
  # get some information
  frm <- model$frame
  names <- row.names(frm)
  ylevels <- attr(model, "ylevels")
  ds.size <- model$frame[1,]$n
  
  # print each leaf node as a rule
  for (i in 1:nrow(frm))
  {
    if (frm[i,1] == "<leaf>")
    {
      # the following [,5] is hardcoded
      cat("\n")
      cat(sprintf(" Rule number: %s ", names[i]))
      cat(sprintf("[yval=%s cover=%d (%.0f%%) prob=%0.2f]\n",
                  ylevels[frm[i,]$yval], frm[i,]$n,
                  round(100*frm[i,]$n/ds.size), frm[i,]$yval2[,5]))
      pth <- path.rpart(model, nodes=as.numeric(names[i]), print.it=FALSE)
      cat(sprintf("   %s\n", unlist(pth)[-1]), sep="")
    }
  }
}

asRules(model)

# basic plot

plot(model)
text(model)

# uniform

plot(model, uniform=TRUE)
text(model)

# extra info

plot(model, uniform=TRUE)
text(model, use.n=TRUE, all=TRUE, cex=.8)

# fancy plot

fancyRpartPlot(model)

# enhanced plot

library(rpart.plot)

prp(model)

# nice

prp(model, type=2, extra=104, nn=TRUE, fallen.leaves=TRUE, faclen=0, varlen=0, shadow.col="grey", branch.lty=3)

# custom colors

col <- c("#FD8D3C", "#FD8D3C", "#FD8D3C", "#BCBDDC", "#FDD0A2", "#FD8D3C", "#BCBDDC")

prp(model, type=2, extra=104, nn=TRUE, fallen.leaves=TRUE, faclen=0, varlen=0, shadow.col="grey", branch.lty=3, box.col=col)

# label nodes

prp(model, type=1)

# labels below nodes

prp(model, type=2)

# split labels

prp(model, type=3)

# interior labels

prp(model, type=4)

# number of observations

prp(model, type=2, extra=1)

# percentage of observations

prp(model, type=2, extra=101)

# enhanced with classification rate

prp(model, type=2, extra=2)

# enhanced with percentage of observations

prp(model, type=2, extra=102)

# misclassification rate

prp(model, type=2, extra=3)

# probability per class

prp(model, type=2, extra=4)

# percentage observations

prp(model, type=2, extra=104)

# only probability per class

prp(model, type=2, extra=5)

# probability of a second class - useful for binary classification

prp(model, type=2, extra=6)

# enhanced with percentage observations - good for bin classification
# each node includes P(second class), usually pos class in bin class dataset

prp(model, type=2, extra=106)

# enhanced, only P(second class)

prp(model, type=2, extra=7)

# enhanced, P(class)

prp(model, type=2, extra=8)

# enhanced: overall probability

prp(model, type=2, extra=9)

# enhanced: percentage of observations

prp(model, type=2, extra=100)

# enhanced with node numbers

prp(model, type=2, extra=106, nn=TRUE)

# node indices

prp(model, type=2, extra=106, nn=TRUE, ni=TRUE)

# line up leaves

prp(model, type=2, extra=106, nn=TRUE, fallen.leaves=TRUE)

# angle branch lines

prp(model, type=2, extra=106, nn=TRUE, fallen.leaves = TRUE, branch=0.5)

# do not abbreviate factors

prp(model, type=2, extra=106, nn=TRUE, fallen.leaves = TRUE, faclen=0)

# shadow

prp(model, type=2, extra=106, nn=TRUE, fallen.leaves=TRUE, shadow.col = "grey")

# dotted line branches

prp(model, type=2, extra=106, nn=TRUE, fallen.leaves=TRUE, branch.lty=3)

# party tree

library(partykit)

class(model)

plot(as.party(model))

# textual representation improved

print(as.party(model))

# conditional decision tree

model <- ctree(formula=form, data=ds[train, vars])

model

# performance

predicted <- predict(model, ds[test, vars], type="prob")[,2]
riskchart(predicted, actual, risks)

predicted <- predict(model, ds[test, vars], type="response")
sum(actual != predicted)/length(predicted)

round(100 * table(actual, predicted, dnn=c("Actual", "Predicted"))/length(predicted))

plot(model)

# RWeka decision tree

library(RWeka)
model <- J48(formula=form, data=ds[train, vars])

model

# performance

predicted <- predict(model, ds[test, vars], type="prob")[,2]
riskchart(predicted, actual, risks)

predicted <- predict(model, ds[test, vars], type="class")
sum(actual != predicted)/length(predicted)

round(100 * table(actual, predicted, dnn=c("Actual", "Predicted"))/length(predicted))

# plot using party

plot(as.party(model))

# text version

print(as.party(model))

# C5.0

library(C50)

model <- C5.0(form, ds[train, vars])

model

C5imp(model)

summary(model)

predicted <- predict(model, ds[test, vars], type="prob")[,2]
riskchart(predicted, actual, risks)

predicted <- predict(model, ds[test, vars], type="class")
sum(actual != predicted)/length(predicted) # Overall error rate

round(100*table(actual, predicted, dnn=c("Actual", "Predicted"))/length(predicted))

# rules-based model

library(C50)
model <- C5.0(form, ds[train, vars], rules=TRUE)
model

C5imp(model)

summary(model)

predicted <- predict(model, ds[test, vars], type="prob")[,2]
riskchart(predicted, actual, risks)

predicted <- predict(model, ds[test, vars], type="class")
sum(ds[test, target] != predicted)/length(predicted) # Overall error rate

round(100*table(ds[test, target], predicted, dnn=c("Actual", "Predicted"))/length(predicted))

# regression tree

target <- "RISK_MM" 
vars <- c(inputs, target) 
form <- formula(paste(target, "~ .")) 
(model <- rpart(formula=form, data=ds[train, vars]))

plot(model) 
text(model)

plot(model, uniform=TRUE) 
text(model)

plot(model, uniform=TRUE) 
text(model, use.n=TRUE, all=TRUE, cex=.8)

fancyRpartPlot(model)

prp(model)

prp(model, type=2, extra=101, nn=TRUE, fallen.leaves=TRUE, faclen=0, varlen=0, shadow.col="grey", branch.lty=3)

# party regression tree

class(model)

plot(as.party(model))

# conditional regression tree

model <- ctree(formula=form, data=ds[train, vars])

model

plot(model)





