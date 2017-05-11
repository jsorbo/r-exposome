rename.column <- function(df, from, to) {
  names(df)[names(df) == from] <- to
  return(df)
}

append.quantile.column <- function(df, column, n) {
  df <- within(df, new_quantile <- as.integer(cut(df[,column], quantile(df[,column], probs=0:n/n), include.lowest=TRUE)))
  new_col_name <- paste0("q.", n, ".quantile.", column)
  names(df)[ncol(df)] <- new_col_name
  return(df)
}

append.quintile.column <- function(df, column) {
  return(append.quantile.column(df, column, 5))
}

convert.quantile.to.binary <- function(df, column, n) {
  for (i in 1:n) {
    df <- within(df, new_col <- as.integer(ifelse(df[column] == i, 1, 0)))
    new_col_name <- paste0(column, ".", i)
    names(df)[ncol(df)] <- new_col_name
  }
  return(df)
}

convert.quintile.to.binary <- function(df, column) {
  return(convert.quantile.to.binary(df, column, 5))
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
    colname <- paste0("q.5.quantile.", column)
  }
  return(df)
}

# function to do multiple runs
multiple.runs.classification <- function(train_fraction, n, dataset, classLabelColumn, formula, prune_tree=FALSE, maxDepth=100) {
  fraction_correct <- rep(NA, n)
  set.seed(42)
  
  for (i in 1:n) {
    dataset[, "train"] <- ifelse(runif(nrow(dataset)) < 0.8, 1, 0)
    
    trainColNum <- grep("train", names(dataset))
    typeColNum <- grep(classLabelColumn, names(dataset))
    trainset <- dataset[dataset$train == 1, -trainColNum]
    testset <- dataset[dataset$train == 0, -trainColNum]
    
    ctrl = rpart.control(maxdepth=maxDepth)
    rpart_model <- rpart(formula, data = trainset, method = "class", control=ctrl)
    
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

convert.to.factors <- function (df, colnames) {
  for (colname in colnames) {
    df[colname] <- lapply(df[colname], as.factor)
  }
  return(df)
}

run.k.means <- function (df, column.list, k) {
  set.seed(43)
  clusters <- kmeans(df[, column.list], k, nstart=20)
  clusters$cluster <- as.factor(clusters$cluster)
  result <- cbind(df, cluster.number=clusters$cluster)
  return(result)
}

set.dataset.from.k.means <- function (df, cluster.number, column.list) {
  return (df[which(df$cluster.number == cluster.number), column.list])
}
