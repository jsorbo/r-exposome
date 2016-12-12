# Using Decision Trees to Predict Infant Birth Weights
# https://www.r-bloggers.com/using-decision-trees-to-predict-infant-birth-weights/

library(MASS)
library(rpart)

# preview birth weight data.
head(birthwt)

# look at distribution of infant birth weights.
hist(birthwt$bwt)

# look at infants born with low birth weight.
table(birthwt$low)

# convert categorical variables to factors.
cols <- c('low', 'race', 'smoke', 'ht', 'ui')
birthwt[cols] <- lapply(birthwt[cols], as.factor)

# split data set into training + testing
set.seed(1)
train <- sample(1:nrow(birthwt), 0.75 * nrow(birthwt))

# build the model
birthwtTree <- rpart(low ~ . - bwt, data = birthwt[train, ], method = 'class')

# view the tree.
plot(birthwtTree)
text(birthwtTree, pretty = 0)

# show detailed summary of the nodes.
summary(birthwtTree)

# see how model performs on test set.
birthwtPred <- predict(birthwtTree, birthwt[-train, ], type = 'class')
table(birthwtPred, birthwt[-train, ]$low)

# birthwtPred  0  1
#           0 31 10
#           1  2  5

# Accuracy = (31 + 5) / 31 + 5 + 2 + 10 = 75%