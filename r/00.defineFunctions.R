rename.column <- function(df, from, to) {
  names(df)[names(df) == from] <- to
  return(df)
}

append.ntile.column <- function(df, column, n) {
  df <- within(df, new_quintile <- as.integer(cut(df[,column], quantile(df[,column], probs=0:n/n), include.lowest=TRUE)))
  new_col_name <- paste0(n, "tile.", column)
  names(df)[ncol(df)] <- new_col_name
  return(df)
}

append.quintile.column <- function(df, column) {
  return(append.ntile.column(df, column, 5))
}

convert.ntile.to.binary <- function(df, column, n) {
  for (i in 1:n) {
    df <- within(df, new_col <- as.integer(ifelse(df[column] == i, 1, 0)))
    new_col_name <- paste0(column, ".", i)
    names(df)[ncol(df)] <- new_col_name
  }
  return(df)
}

convert.quintile.to.binary <- function(df, column) {
  return(convert.ntile.to.binary(df, column, 5))
}

convert.vector.of.columns.to.binary <- function(df, columns) {
  for (column in columns) {
    df <- append.quintile.column(df, column)
    colname <- paste0("5tile.", column)
    df <- convert.quintile.to.binary(df, colname)
  }
  return(df)
}

convert.vector.of.columns.to.quintiles <- function(df, columns) {
  for (column in columns) {
    df <- append.quintile.column(df, column)
    colname <- paste0("5tile.", column)
  }
  return(df)
}

# function to do multiple runs
multiple.runs.classification <- function(train_fraction, n, dataset, classLabelColumn, formula, prune_tree = FALSE) {
  fraction_correct <- rep(NA, n)
  set.seed(42)
  
  for (i in 1:n) {
    dataset[, "train"] <- ifelse(runif(nrow(dataset)) < 0.8, 1, 0)
    
    trainColNum <- grep("train", names(dataset))
    typeColNum <- grep(classLabelColumn, names(dataset))
    trainset <- dataset[dataset$train == 1, -trainColNum]
    testset <- dataset[dataset$train == 0, -trainColNum]
    
    rpart_model <- rpart(formula, data = trainset, method = "class")
    
    if (prune_tree == FALSE) {
      rpart_test_predict <- predict(rpart_model, testset[, -typeColNum], type = "class")
      fraction_correct[i] <- mean(rpart_test_predict == testset[, classLabelColumn])
    } else {
      opt <- which.min(rpart_model$cptable[, "xerror"])
      cp <- rpart_model$cptable[opt, "CP"]
      pruned_model <- prune(rpart_model, cp)
      rpart_pruned_predict <- predict(pruned_model, testset[, -typeColNum], type = "class")
      fraction_correct[i] <- mean(rpart_pruned_predict == testset$cvd)
    }
  }
  return(fraction_correct)
}

