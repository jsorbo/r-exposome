merged <- convert.to.factors(merged, column.list.paraclique.5tiles)

kMeansDataSet <- merged[, c(column.list.paraclique.5tiles, "cvd")]

merged <- convert.to.factors(merged, column.list.all.5tiles)

kMeansDataSet <- merged[, c(column.list.all.5tiles, "cvd")]

################################################################################
# chi squared

weights <- chi.squared(cvd ~ ., kMeansDataSet)

################################################################################
# symmetrical uncertainty

weights <- symmetrical.uncertainty(cvd ~ ., kMeansDataSet)

################################################################################
# gain ratio

weights <- gain.ratio(cvd ~ ., kMeansDataSet)

subset <- cutoff.k(weights, 5)

f <- as.simple.formula(subset, "cvd")

print(f)

column.list.feature.reduction <- subset

set.seed(43)

clusters = kmeans(kMeansDataSet[, column.list.all.5tiles], 3, nstart=20)

clusters$cluster <- as.factor(clusters$cluster)

kMeansDataSet <- cbind(kMeansDataSet, clusterNum=clusters$cluster)
