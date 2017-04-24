################################################################################
# 3. select data set from options below

# dataset 1 is ten variables from paraclique plus cvd

dataset <- merged[,c("b_1999", "b_2000", "averagesmoke1996to2000", "percent2004diabetes",
                     "ageadjustedpercent2004diabetes", "percentobesity2004", "ageadjustedpercentobesity2004", 
                     "percentleisuretimephysicalinactivityprevalence2004",
                     "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "PH_SODA", "Quintiles")]

dataset <- merged[,c("5tile.b_1999", "5tile.b_2000", "5tile.averagesmoke1996to2000", "5tile.percent2004diabetes",
                     "5tile.ageadjustedpercent2004diabetes", "5tile.percentobesity2004", 
                     "5tile.ageadjustedpercentobesity2004", "5tile.percentleisuretimephysicalinactivityprevalence2004",
                     "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "5tile.PH_SODA", "cvd")]

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

dataset <- merged[,c(column.list.pca.5tiles, "cvd")]

# dataset 3 is selected from pca after eliminating raw quantity variables

dataset <- merged[,c("5tile.sampleMedianHousingUnitValue", 
                     "5tile.unemploymentRate", 
                     "5tile.populationPerSquareMile", 
                     "cvd")]

dataset <- merged[,c("5tile.educationHighSchoolOrAboveRate", 
                     "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004", 
                     "5tile.percentleisuretimephysicalinactivityprevalence2004", 
                     "5tile.perCapitaIncome", 
                     "5tile.medianHouseholdIncome2000", 
                     "5tile.peopleInPovertyRate", 
                     "5tile.ageadjustedpercentobesity2004", 
                     "5tile.perCapitaPersonalIncome", 
                     "5tile.percentobesity2004", 
                     "5tile.AvgDailyMaxAirTemperatureF", 
                     "5tile.AvgDailyMinAirTemperatureF", 
                     "5tile.AvgDailyMaxHeatIndexF", 
                     "5tile.AvgDayLandSurfaceTemperatureF", 
                     "5tile.AvgDailyPrecipitationmm", 
                     "5tile.AvgFineParticulateMatterµgm", 
                     "5tile.percent2004diabetes", 
                     "5tile.populationMedianAgeApril2000", 
                     "5tile.ageadjustedpercent2004diabetes",
                     "5tile.fastFoodRestaurantsPer1000",
                     "5tile.fullServiceRestaurantsPer1000",
                     "cvd")]

dataset <- kMeansDataSet[which(kMeansDataSet$clusterNum == 3), c(column.list.pca, "cvd")]

