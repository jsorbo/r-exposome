################################################################################
# 4. prepare for decision tree modeling

# Build the training/validate/test datasets.

# set seed to ensure reproducible results
set.seed(42)

# split into training and test sets
dataset[,"train"] <- ifelse(runif(nrow(dataset))<0.8,1,0)

# separate training and test sets
trainset <- dataset[dataset$train == 1,]
testset <- dataset[dataset$train == 0,]

# get column index of train flag
trainColNum <- grep("train", names(trainset))

# remove train flag column
trainset <- trainset[,-trainColNum]
testset <- testset[,-trainColNum]

# get column index of predicted variable
typeColNum <- grep("Quintiles", names(dataset))

