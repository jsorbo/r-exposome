convert.to.factors <- function (df, colnames) {
  for (colname in colnames) {
    df[colname] <- lapply(df[colname], as.factor)
  }
  return(df)
}

merged <- convert.to.factors(merged, column.list.pca.5tiles)

kMeansDataSet <- merged[, c(column.list.pca, "cvd")]

weights <- chi.squared(cvd ~ ., kMeansDataSet)

subset <- cutoff.k(weights, 5)

f <- as.simple.formula(subset, "cvd")

print(f)

column.list.pca = subset

set.seed(43)

clusters = kmeans(kMeansDataSet[, column.list.pca], 3, nstart=20)

clusters$cluster <- as.factor(clusters$cluster)

kMeansDataSet <- cbind(kMeansDataSet, clusterNum=clusters$cluster)
