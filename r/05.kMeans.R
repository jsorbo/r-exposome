################################################################################
# define data sets for k-means

kMeansDataSet <- merged[, c(column.list.paraclique.5tiles, "cvd")]

kMeansDataSet <- merged[, c(column.list.all.5tiles, "cvd")]

################################################################################
# convert to factors (used for feature reduction methods)

kMeansDataSet <- convert.to.factors(kMeansDataSet, column.list.paraclique.5tiles)

kMeansDataSet <- convert.to.factors(kMeansDataSet, column.list.all.5tiles)

################################################################################
# feature reduction: chi squared

weights <- chi.squared(cvd ~ ., kMeansDataSet)

################################################################################
# feature reduction: symmetrical uncertainty

weights <- symmetrical.uncertainty(cvd ~ ., kMeansDataSet)

################################################################################
# feature reduction: gain ratio

weights <- gain.ratio(cvd ~ ., kMeansDataSet)

################################################################################
# feature reduction: select features based on weights

subset <- cutoff.k(weights, 5)

f <- as.simple.formula(subset, "cvd")

print(f)

column.list.feature.reduction <- subset

################################################################################
# run k-means

kMeansDataSet <- run.k.means(kMeansDataSet, column.list.paraclique.5tiles, 3)

kMeansDataSet <- run.k.means(kMeansDataSet, column.list.all.5tiles, 3)
