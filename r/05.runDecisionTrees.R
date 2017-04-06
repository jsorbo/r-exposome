################################################################################
# 5. build decision trees

# build model
rpart_model <- rpart(Quintiles ~ ., data = trainset, method = "class")

# plot tree
rpart.plot(rpart_model)

# try against test data
rpart_predict <- predict(rpart_model, testset[, -typeColNum], type = "class")
mean(rpart_predict == testset$Quintiles)

# confusion matrix
table(pred = rpart_predict, true = testset$Quintiles)

# cost-complexity pruning
# pick the appropriate pruning parameter alpha by
# picking the value that results in the lowest prediction error
# alpha = CP
# cross-val error = xerror

printcp(rpart_model)

# get index of CP with lowest xerror
opt <- which.min(rpart_model$cptable[, "xerror"])

# get its value
cp <- rpart_model$cptable[opt, "CP"]

# prune the tree based on cp
pruned_model <- prune(rpart_model, cp)

# plot
rpart.plot(pruned_model)

# find proportion of correct predictions using test set
rpart_pruned_predict <- predict(pruned_model, testset[, -typeColNum], type = "class")
mean(rpart_pruned_predict == testset$Quintiles)

# function to do multiple runs
multiple_runs_classification <- function(train_fraction, n, dataset, prune_tree = FALSE) {
  fraction_correct <- rep(NA, n)
  set.seed(42)
  
  for (i in 1:n) {
    dataset[, "train"] <- ifelse(runif(nrow(dataset)) < 0.8, 1, 0)
    
    trainColNum <- grep("train", names(dataset))
    typeColNum <- grep("Quintiles", names(dataset))
    trainset <- dataset[dataset$train == 1, -trainColNum]
    testset <- dataset[dataset$train == 0, -trainColNum]
    
    rpart_model <- rpart(Quintiles ~ ., data = trainset, method = "class")
    
    if (prune_tree == FALSE) {
      rpart_test_predict <- predict(rpart_model, testset[, -typeColNum], type = "class")
      fraction_correct[i] <- mean(rpart_test_predict == testset$Quintiles)
    } else {
      opt <- which.min(rpart_model$cptable[, "xerror"])
      cp <- rpart_model$cptable[opt, "CP"]
      pruned_model <- prune(rpart_model, cp)
      rpart_pruned_predict <- predict(pruned_model, testset[, -typeColNum], type = "class")
      fraction_correct[i] <- mean(rpart_pruned_predict == testset$Quintiles)
    }
  }
  return(fraction_correct)
}

# 50 runs without pruning
unpruned_set <- multiple_runs_classification(0.8, 50, dataset)
mean(unpruned_set)
sd(unpruned_set)

# 50 runs with pruning
pruned_set <- multiple_runs_classification(0.8, 50, dataset, prune_tree = TRUE)
mean(pruned_set)
sd(pruned_set)

