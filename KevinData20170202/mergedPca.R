

#============================================================
# Rattle timestamp: 2017-03-02 20:30:58 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare", "violentCrimes",
     "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile", "urbanPopulationSample",
     "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount",
     "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife",
     "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea",
     "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm",
     "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF",
     "populationApril2000", "populationJuly2000", "b_1996", "b_1997",
     "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000",
     "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes",
     "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome",
     "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004",
     "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07",
     "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA",
     "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare",
     "CountyCode", "Deaths", "Population", "Crude",
     "ageadjustedrate", "PCT_CVD_death")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare", "violentCrimes",
     "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile", "urbanPopulationSample",
     "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount",
     "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife",
     "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea",
     "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm",
     "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF",
     "populationApril2000", "populationJuly2000", "b_1996", "b_1997",
     "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000",
     "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes",
     "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome",
     "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004",
     "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07",
     "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA",
     "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare",
     "CountyCode", "Deaths", "Population", "Crude",
     "PCT_CVD_death")

crs$categoric <- "ageadjustedrate"

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- "STCOU"
crs$ignore  <- "Areaname"
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-03-02 20:44:01 x86_64-w64-mingw32 

# Principal Components Analysis (on numerics only).

pc <- prcomp(na.omit(crs$dataset[crs$sample, crs$numeric]), scale=TRUE, center=TRUE, tol=0)

# Show the output of the analysis.

pc

# Summarise the importance of the components found.

summary(pc)

# Display a plot showing the relative importance of the components.

plot(pc, main="")
title(main="Principal Components Importance merged",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))
axis(1, at=seq(0.7, ncol(pc$rotation)*1.2, 1.2), labels=colnames(pc$rotation), lty=0)

# Display a plot showing the two most principal components.

biplot(pc, main="")
title(main="Principal Components merged",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))
