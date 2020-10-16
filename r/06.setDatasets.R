################################################################################
# 3. select data set from options below

# dataset 1 is ten variables from paraclique plus cvd

dataset <- merged[,c("b_1999", "b_2000", "averagesmoke1996to2000", "percent2004diabetes",
                     "ageadjustedpercent2004diabetes", "percentobesity2004", "ageadjustedpercentobesity2004", 
                     "percentleisuretimephysicalinactivityprevalence2004",
                     "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "PH_SODA", "Quintiles")]

dataset <- merged[,c("q.5.quantile.b_1999", "q.5.quantile.b_2000", "q.5.quantile.averagesmoke1996to2000", "q.5.quantile.percent2004diabetes",
                     "q.5.quantile.ageadjustedpercent2004diabetes", "q.5.quantile.percentobesity2004", 
                     "q.5.quantile.ageadjustedpercentobesity2004", "q.5.quantile.percentleisuretimephysicalinactivityprevalence2004",
                     "q.5.quantile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "q.5.quantile.PH_SODA", "cvd")]

# dataset 2 is selected from pca after eliminating raw quantity variables

dataset <- merged[,c("educationHighSchoolOrAboveRate", 
                     "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", 
                     "percentleisuretimephysicalinactivityprevalence2004", 
                     "perCapitaIncome", 
                     "medianHouseholdIncome2000", 
                     "peopleInPovertyRate", 
                     "ageadjustedpercentobesity2004", 
                     "perCapitaPersonalIncome", 
                     "percentobesity2004", 
                     "sampleMedianHousingUnitValue", 
                     "AvgDailyMaxAirTemperatureF", 
                     "AvgDailyMinAirTemperatureF", 
                     "AvgDailyMaxHeatIndexF", 
                     "unemploymentRate", 
                     "AvgDayLandSurfaceTemperatureF", 
                     "AvgDailyPrecipitationmm", 
                     "AvgFineParticulateMatterµgm", 
                     "populationPerSquareMile", 
                     "percent2004diabetes", 
                     "populationMedianAgeApril2000", 
                     "ageadjustedpercent2004diabetes",
                     "cvd")]

# dataset 2 is selected from pca after eliminating raw quantity variables

dataset <- merged[,c(column.list.all.5tiles, "cvd")]

# dataset 3 is selected from pca after eliminating raw quantity variables

dataset <- merged[,c("q.5.quantile.sampleMedianHousingUnitValue", 
                     "q.5.quantile.unemploymentRate", 
                     "q.5.quantile.populationPerSquareMile", 
                     "cvd")]

dataset <- merged[,c("q.5.quantile.educationHighSchoolOrAboveRate", 
                     "q.5.quantile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004", 
                     "q.5.quantile.percentleisuretimephysicalinactivityprevalence2004", 
                     "q.5.quantile.perCapitaIncome", 
                     "q.5.quantile.medianHouseholdIncome2000", 
                     "q.5.quantile.peopleInPovertyRate", 
                     "q.5.quantile.ageadjustedpercentobesity2004", 
                     "q.5.quantile.perCapitaPersonalIncome", 
                     "q.5.quantile.percentobesity2004", 
                     "q.5.quantile.AvgDailyMaxAirTemperatureF", 
                     "q.5.quantile.AvgDailyMinAirTemperatureF", 
                     "q.5.quantile.AvgDailyMaxHeatIndexF", 
                     "q.5.quantile.AvgDayLandSurfaceTemperatureF", 
                     "q.5.quantile.AvgDailyPrecipitationmm", 
                     "q.5.quantile.AvgFineParticulateMatterµgm", 
                     "q.5.quantile.percent2004diabetes", 
                     "q.5.quantile.populationMedianAgeApril2000", 
                     "q.5.quantile.ageadjustedpercent2004diabetes",
                     "q.5.quantile.fastFoodRestaurantsPer1000",
                     "q.5.quantile.fullServiceRestaurantsPer1000",
                     "cvd")]

dataset <- merged[, c(column.list.paraclique.5tiles, "cvd")]

dataset <- merged[, c(column.list.all.5tiles, "cvd")]

dataset <- set.dataset.from.k.means(kMeansDataSet, 1, c(column.list.paraclique.5tiles, "cvd"))
dataset <- set.dataset.from.k.means(kMeansDataSet, 2, c(column.list.paraclique.5tiles, "cvd"))
dataset <- set.dataset.from.k.means(kMeansDataSet, 3, c(column.list.paraclique.5tiles, "cvd"))

dataset <- set.dataset.from.k.means(kMeansDataSet, 1, c(column.list.all.5tiles, "cvd"))
dataset <- set.dataset.from.k.means(kMeansDataSet, 2, c(column.list.all.5tiles, "cvd"))
dataset <- set.dataset.from.k.means(kMeansDataSet, 3, c(column.list.all.5tiles, "cvd"))

dataset <- kMeansDataSet[, c(column.list.feature.reduction, "cvd")]