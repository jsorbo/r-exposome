# Rattle is Copyright (c) 2006-2015 Togaware Pty Ltd.

#============================================================
# Rattle timestamp: 2016-12-21 19:34:51 x86_64-w64-mingw32 

# Rattle version 4.1.0 user 'jsorbo'

# This log file captures all Rattle interactions as R commands. 

Export this log to a file using the Export button or the Tools 
# menu to save a log of all your activity. This facilitates repeatability. For example, exporting 
# to a file called 'myrf01.R' will allow you to type in the R Console 
# the command source('myrf01.R') and so repeat all actions automatically. 
# Generally, you will want to edit the file to suit your needs. You can also directly 
# edit this current log in place to record additional information before exporting. 
 
# Saving and loading projects also retains this log.

# We begin by loading the required libraries.

library(rattle)   # To access the weather dataset and utility commands.
library(magrittr) # For the %>% and %<>% operators.

# This log generally records the process of building a model. However, with very 
# little effort the log can be used to score a new dataset. The logical variable 
# 'building' is used to toggle between generating transformations, as when building 
# a model, and simply using the transformations, as when scoring a dataset.

building <- TRUE
scoring  <- ! building


# A pre-defined value is used to reset the random seed so that results are repeatable.

crv$seed <- 42 

#============================================================
# Rattle timestamp: 2016-12-21 19:34:57 x86_64-w64-mingw32 

# Load the data.

crs$dataset <- read.csv(system.file("csv", "weather.csv", package="rattle"), encoding="UTF-8")

#============================================================
# Rattle timestamp: 2016-12-21 19:34:58 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 366 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 256 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 54 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 56 observations

# The following variable selections have been noted.

crs$input <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation",
     "Sunshine", "WindGustDir", "WindGustSpeed", "WindDir9am",
     "WindDir3pm", "WindSpeed9am", "WindSpeed3pm", "Humidity9am",
     "Humidity3pm", "Pressure9am", "Pressure3pm", "Cloud9am",
     "Cloud3pm", "Temp9am", "Temp3pm", "RainToday")

crs$numeric <- c("MinTemp", "MaxTemp", "Rainfall", "Evaporation",
     "Sunshine", "WindGustSpeed", "WindSpeed9am", "WindSpeed3pm",
     "Humidity9am", "Humidity3pm", "Pressure9am", "Pressure3pm",
     "Cloud9am", "Cloud3pm", "Temp9am", "Temp3pm")

crs$categoric <- c("WindGustDir", "WindDir9am", "WindDir3pm", "RainToday")

crs$target  <- "RainTomorrow"
crs$risk    <- "RISK_MM"
crs$ident   <- "Date"
crs$ignore  <- "Location"
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2016-12-21 19:35:04 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(RainTomorrow ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.02 secs

#============================================================
# Rattle timestamp: 2016-12-21 19:35:06 x86_64-w64-mingw32 

# Plot the resulting Decision Tree. 

# We use the rpart.plot package.

fancyRpartPlot(crs$rpart, main="Decision Tree weather.csv $ RainTomorrow")

#============================================================
# Rattle timestamp: 2016-12-21 19:39:41 x86_64-w64-mingw32 

# Evaluate model performance. 

# Generate an Error Matrix for the Decision Tree model.

# Obtain the response from the Decision Tree model.

crs$pr <- predict(crs$rpart, newdata=crs$dataset[crs$validate, c(crs$input, crs$target)], type="class")

# Generate the confusion matrix showing counts.

table(crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow, crs$pr,
        useNA="ifany",
        dnn=c("Actual", "Predicted"))

# Generate the confusion matrix showing proportions.

pcme <- function(actual, cl)
{
  x <- table(actual, cl)
  nc <- nrow(x) # Number of classes.
  nv <- length(actual) - sum(is.na(actual) | is.na(cl)) # Number of values.
  tbl <- cbind(x/nv,
               Error=sapply(1:nc,
                 function(r) round(sum(x[r,-r])/sum(x[r,]), 2)))
  names(attr(tbl, "dimnames")) <- c("Actual", "Predicted")
  return(tbl)
}
per <- pcme(crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow, crs$pr)
round(per, 2)

# Calculate the overall error percentage.

cat(100*round(1-sum(diag(per), na.rm=TRUE), 2))

# Calculate the averaged class error percentage.

cat(100*round(mean(per[,"Error"], na.rm=TRUE), 2))

#============================================================
# Rattle timestamp: 2016-12-21 19:45:37 x86_64-w64-mingw32 

# Evaluate model performance. 

# Risk Chart: requires the ggplot2 package.

library(ggplot2)

# Generate a risk chart.

# Rattle provides evaluateRisk() and riskchart().

crs$pr <- predict(crs$rpart, newdata=crs$dataset[crs$validate, c(crs$input, crs$target)])[,2]
crs$eval <- evaluateRisk(crs$pr, 
    crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow, 
    crs$dataset[crs$validate, c(crs$input, crs$target, crs$risk)]$RISK_MM)
print(riskchart(crs$pr,
                crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow, 
                crs$dataset[crs$validate, c(crs$input, crs$target, crs$risk)]$RISK_MM, 
                title="Risk Chart Decision Tree weather.csv [validate] RainTomorrow ", 
                risk.name="RISK_MM", recall.name="RainTomorrow",
                show.lift=TRUE, show.precision=TRUE, legend.horiz=FALSE))


#============================================================
# Rattle timestamp: 2016-12-21 20:05:53 x86_64-w64-mingw32 

# Evaluate model performance. 

# ROC Curve: requires the ROCR package.

library(ROCR)

# ROC Curve: requires the ggplot2 package.

library(ggplot2, quietly=TRUE)

# Generate an ROC Curve for the rpart model on weather.csv [validate].

crs$pr <- predict(crs$rpart, newdata=crs$dataset[crs$validate, c(crs$input, crs$target)])[,2]

# Remove observations with missing target.

no.miss   <- na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow)
miss.list <- attr(no.miss, "na.action")
attributes(no.miss) <- NULL

if (length(miss.list))
{
  pred <- prediction(crs$pr[-miss.list], no.miss)
} else
{
  pred <- prediction(crs$pr, no.miss)
}

pe <- performance(pred, "tpr", "fpr")
au <- performance(pred, "auc")@y.values[[1]]
pd <- data.frame(fpr=unlist(pe@x.values), tpr=unlist(pe@y.values))
p <- ggplot(pd, aes(x=fpr, y=tpr))
p <- p + geom_line(colour="red")
p <- p + xlab("False Positive Rate") + ylab("True Positive Rate")
p <- p + ggtitle("ROC Curve Decision Tree weather.csv [validate] RainTomorrow")
p <- p + theme(plot.title=element_text(size=10))
p <- p + geom_line(data=data.frame(), aes(x=c(0,1), y=c(0,1)), colour="grey")
p <- p + annotate("text", x=0.50, y=0.00, hjust=0, vjust=0, size=5,
                   label=paste("AUC =", round(au, 2)))
print(p)

# Calculate the area under the curve for the plot.


# Remove observations with missing target.

no.miss   <- na.omit(crs$dataset[crs$validate, c(crs$input, crs$target)]$RainTomorrow)
miss.list <- attr(no.miss, "na.action")
attributes(no.miss) <- NULL

if (length(miss.list))
{
  pred <- prediction(crs$pr[-miss.list], no.miss)
} else
{
  pred <- prediction(crs$pr, no.miss)
}
performance(pred, "auc")

#============================================================
# Rattle timestamp: 2016-12-21 20:27:44 x86_64-w64-mingw32 

# Score a dataset. 

# Obtain probability scores for the Decision Tree model on weather.csv [validate].

crs$pr <- predict(crs$rpart, newdata=crs$dataset[crs$validate, c(crs$input)], type="class")

# Extract the relevant variables from the dataset.

sdata <- subset(crs$dataset[crs$validate,], select=c("Date", "RainTomorrow"))

# Output the combined data.

write.csv(cbind(sdata, crs$pr), file="C:\repos\MsseProject\RScripts\RScripts\weather_validate_score_idents.csv", row.names=FALSE)
