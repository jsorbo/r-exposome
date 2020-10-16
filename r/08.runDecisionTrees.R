################################################################################
# 5. build decision trees

# build model
ctrl = rpart.control(maxdepth=10)
rpart_model <- rpart(cvd ~ ., data = trainset, method = "class", control=ctrl)

# plot tree
# rpart.plot(rpart_model)

# this is a better-looking option
fancyRpartPlot(rpart_model, sub="")

# try against test data
rpart_predict <- predict(rpart_model, testset[, -typeColNum], type = "class")
mean(rpart_predict == testset$cvd)

# confusion matrix
table(pred = rpart_predict, true = testset$cvd)

rules <- asRules(rpart_model)

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
fancyRpartPlot(pruned_model, sub="")

# find proportion of correct predictions using test set
rpart_pruned_predict <- predict(pruned_model, testset[, -typeColNum], type = "class")
mean(rpart_pruned_predict == testset$cvd)

# 50 runs without pruning
unpruned_set <- multiple.runs.classification(0.8, 50, dataset, "cvd", cvd ~ ., maxDepth=3)
mean(unpruned_set)
sd(unpruned_set)

# 50 runs with pruning
pruned_set <- multiple.runs.classification(0.8, 50, dataset, "cvd", cvd ~ ., prune_tree=TRUE, maxDepth=3)
mean(pruned_set)
sd(pruned_set)

