# Rattle is Copyright (c) 2006-2015 Togaware Pty Ltd.

#============================================================
# Rattle timestamp: 2017-02-22 21:20:19 x86_64-w64-mingw32 

# Rattle version 4.1.0 user 'jsorbo'

# This log file captures all Rattle interactions as R commands. 

Export this log to a file using the Export button or the Tools 
# menu to save a log of all your activity. This facilitates repeatability. For example, exporting 
# to a file called 'myrf01.R' will allow you to type in the R Console 
# the command source('myrf01.R') and so repeat all actions automatically. 
# Generally, you will want to edit the file to suit your needs. You can also directly 
# edit this current log in place to record additional information before exporting. 
 
# Saving and loading projects also retains this log.

# We begin by loading the required libraries.

library(rattle)   # To access the weather dataset and utility commands.
library(magrittr) # For the %>% and %<>% operators.

# This log generally records the process of building a model. However, with very 
# little effort the log can be used to score a new dataset. The logical variable 
# 'building' is used to toggle between generating transformations, as when building 
# a model, and simply using the transformations, as when scoring a dataset.

building <- TRUE
scoring  <- ! building


# A pre-defined value is used to reset the random seed so that results are repeatable.

crv$seed <- 42 

#============================================================
# Rattle timestamp: 2017-02-22 21:22:29 x86_64-w64-mingw32 

# Load an R data frame.

crs$dataset <- merged

# Display a simple summary (structure) of the dataset.

str(crs$dataset)

#============================================================
# Rattle timestamp: 2017-02-22 21:22:31 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("Areaname", "medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare",
     "violentCrimes", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile",
     "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount",
     "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino",
     "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients",
     "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm",
     "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF",
     "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996",
     "b_1997", "b_1998", "b_1999", "b_2000",
     "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes",
     "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue",
     "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004",
     "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI",
     "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS",
     "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD",
     "medicare", "CountyCode", "Deaths", "Population",
     "Crude", "ageadjustedrate", "PCT_CVD_death")

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

crs$categoric <- c("Areaname", "ageadjustedrate")

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- "STCOU"
crs$ignore  <- NULL
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 21:25:04 x86_64-w64-mingw32 

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
     "malePopulationCompleteCount", "femalePopulationCompleteCount")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare", "violentCrimes",
     "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile", "urbanPopulationSample",
     "malePopulationCompleteCount", "femalePopulationCompleteCount")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 21:26:07 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.27 secs

#============================================================
# Rattle timestamp: 2017-02-22 21:27:02 x86_64-w64-mingw32 

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
     "femalePopulationCompleteCount")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare", "violentCrimes",
     "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile", "urbanPopulationSample",
     "femalePopulationCompleteCount")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "malePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 21:27:05 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.24 secs

#============================================================
# Rattle timestamp: 2017-02-22 21:27:22 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare", "violentCrimes",
     "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile", "urbanPopulationSample")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "insuranceOrMedicare", "violentCrimes",
     "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate", "populationPerSquareMile", "urbanPopulationSample")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 21:27:25 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.25 secs

#============================================================
# Rattle timestamp: 2017-02-22 21:28:58 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("peopleInPovertyRate", "violentCrimes", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate",
     "populationPerSquareMile")

crs$numeric <- c("peopleInPovertyRate", "violentCrimes", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate",
     "populationPerSquareMile")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "medianHouseholdIncome2000", "insuranceOrMedicare", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 21:29:04 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.16 secs

#============================================================
# Rattle timestamp: 2017-02-22 21:29:49 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate")

crs$numeric <- c("peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "medianHouseholdIncome2000", "insuranceOrMedicare", "violentCrimes", "populationPerSquareMile", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 21:29:52 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.37 secs

#============================================================
# Rattle timestamp: 2017-02-22 22:24:28 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "insuranceOrMedicare", "violentCrimes", "populationPerSquareMile", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 22:24:31 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.21 secs

#============================================================
# Rattle timestamp: 2017-02-22 22:24:53 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "violentCrimes", "perCapitaPersonalIncome",
     "educationHighSchoolOrAboveRate")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "violentCrimes", "perCapitaPersonalIncome",
     "educationHighSchoolOrAboveRate")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "insuranceOrMedicare", "populationPerSquareMile", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 22:24:59 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.32 secs

#============================================================
# Rattle timestamp: 2017-02-22 22:25:15 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate",
     "populationPerSquareMile")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate",
     "populationPerSquareMile")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "insuranceOrMedicare", "violentCrimes", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 22:25:47 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.19 secs

#============================================================
# Rattle timestamp: 2017-02-22 22:28:44 x86_64-w64-mingw32 

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
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 22:28:49 x86_64-w64-mingw32 

# KMeans 

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# The 'reshape' package provides the 'rescaler' function.

library(reshape, quietly=TRUE)

# Generate a kmeans cluster of size 10.

crs$kmeans <- kmeans(sapply(na.omit(crs$dataset[crs$sample, crs$numeric]), rescaler, "range"), 10)

#============================================================
# Rattle timestamp: 2017-02-22 22:28:59 x86_64-w64-mingw32 

# Report on the cluster characteristics. 

# Cluster sizes:

paste(crs$kmeans$size, collapse=' ')

# Data means:

colMeans(sapply(na.omit(crs$dataset[crs$sample, crs$numeric]), rescaler, "range"))

# Cluster centers:

crs$kmeans$centers

# Within cluster sum of squares:

crs$kmeans$withinss

# Time taken: 0.30 secs

#============================================================
# Rattle timestamp: 2017-02-22 23:20:11 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate",
     "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF",
     "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate",
     "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF",
     "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "insuranceOrMedicare", "violentCrimes", "populationPerSquareMile", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-22 23:20:16 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.45 secs

#============================================================
# Rattle timestamp: 2017-02-22 23:38:34 x86_64-w64-mingw32 

# Plot the resulting Decision Tree. 

# We use the rpart.plot package.

fancyRpartPlot(crs$rpart, main="Decision Tree merged $ Quintiles")

#============================================================
# Rattle timestamp: 2017-02-23 10:04:33 x86_64-w64-mingw32 

# Evaluate model performance. 

# Generate an Error Matrix for the Decision Tree model.

# Obtain the response from the Decision Tree model.

crs$pr <- predict(crs$rpart, newdata=crs$dataset[crs$validate, c(crs$input, crs$target)], type="class")

# Generate the confusion matrix showing counts.

table(crs$dataset[crs$validate, c(crs$input, crs$target)]$Quintiles, crs$pr,
        useNA="ifany",
        dnn=c("Actual", "Predicted"))

# Generate the confusion matrix showing proportions.

pcme <- function(actual, cl)
{
  x <- table(actual, cl)
  nc <- nrow(x) # Number of classes.
  nv <- length(actual) - sum(is.na(actual) | is.na(cl)) # Number of values.
  tbl <- cbind(x/nv,
               Error=sapply(1:nc,
                 function(r) round(sum(x[r,-r])/sum(x[r,]), 2)))
  names(attr(tbl, "dimnames")) <- c("Actual", "Predicted")
  return(tbl)
}
per <- pcme(crs$dataset[crs$validate, c(crs$input, crs$target)]$Quintiles, crs$pr)
round(per, 2)

# Calculate the overall error percentage.

cat(100*round(1-sum(diag(per), na.rm=TRUE), 2))

# Calculate the averaged class error percentage.

cat(100*round(mean(per[,"Error"], na.rm=TRUE), 2))

#============================================================
# Rattle timestamp: 2017-02-23 10:25:43 x86_64-w64-mingw32 

# KMeans 

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# The 'reshape' package provides the 'rescaler' function.

library(reshape, quietly=TRUE)

# Generate a kmeans cluster of size 10.

crs$kmeans <- kmeans(sapply(na.omit(crs$dataset[crs$sample, crs$numeric]), rescaler, "range"), 10)

#============================================================
# Rattle timestamp: 2017-02-23 10:25:44 x86_64-w64-mingw32 

# Report on the cluster characteristics. 

# Cluster sizes:

paste(crs$kmeans$size, collapse=' ')

# Data means:

colMeans(sapply(na.omit(crs$dataset[crs$sample, crs$numeric]), rescaler, "range"))

# Cluster centers:

crs$kmeans$centers

# Within cluster sum of squares:

crs$kmeans$withinss

# Time taken: 0.03 secs

#============================================================
# Rattle timestamp: 2017-02-23 23:58:31 x86_64-w64-mingw32 

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
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-23 23:58:38 x86_64-w64-mingw32 

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

#============================================================
# Rattle timestamp: 2017-02-24 00:13:18 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 2978 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 2084 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 446 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 448 observations

# The following variable selections have been noted.

crs$input <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate")

crs$numeric <- c("medianHouseholdIncome2000", "peopleInPovertyRate", "perCapitaPersonalIncome", "educationHighSchoolOrAboveRate")

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "insuranceOrMedicare", "violentCrimes", "populationPerSquareMile", "urbanPopulationSample", "malePopulationCompleteCount", "femalePopulationCompleteCount", "populationOfOneRaceWhiteAloneCompleteCount", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount", "renterOccupiedHousingUnits", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican", "renterOccupiedHomesHouseholderHispanicOrLatino", "householdsMaleNoWife", "householdsFemaleNoHusband", "socialSecurityBenefitRecipients", "supplementalSecurityIncomeRecipients", "landArea", "unemploymentRate", "bankOfficesJune2000", "AvgFineParticulateMatterÂµgm", "AvgDailyPrecipitationmm", "AvgDayLandSurfaceTemperatureF", "AvgDailyMaxAirTemperatureF", "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF", "populationApril2000", "populationJuly2000", "b_1996", "b_1997", "b_1998", "b_1999", "b_2000", "averagesmoke1996to2000", "populationMedianAgeApril2000", "number2004diabetes", "percent2004diabetes", "ageadjustedpercent2004diabetes", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican", "ownerOccupiedHomesHouseholderHispanicOrLatino", "sampleMedianHousingUnitValue", "perCapitaIncome", "numberobesityprevalence2004", "percentobesity2004", "ageadjustedpercentobesity2004", "numberleisuretimephysicalinactivityprevalence2004", "percentleisuretimephysicalinactivityprevalence2004", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "HHNV1MI", "FFRPTH07", "FSRPTH07", "PH_FRUVEG", "PH_SNACKS", "PH_SODA", "PH_MEAT", "PH_FATS", "PH_PREPFOOD", "medicare", "CountyCode", "Deaths", "Population", "Crude", "ageadjustedrate", "PCT_CVD_death")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-24 00:13:29 x86_64-w64-mingw32 

# Decision Tree 

# The 'rpart' package provides the 'rpart' function.

library(rpart, quietly=TRUE)

# Reset the random number seed to obtain the same results each time.

set.seed(crv$seed)

# Build the Decision Tree model.

crs$rpart <- rpart(Quintiles ~ .,
    data=crs$dataset[crs$train, c(crs$input, crs$target)],
    method="class",
    parms=list(split="information"),
    control=rpart.control(usesurrogate=0, 
        maxsurrogate=0))

# Generate a textual view of the Decision Tree model.

print(crs$rpart)
printcp(crs$rpart)
cat("\n")

# Time taken: 0.26 secs

#============================================================
# Rattle timestamp: 2017-02-24 00:13:52 x86_64-w64-mingw32 

# Plot the resulting Decision Tree. 

# We use the rpart.plot package.

fancyRpartPlot(crs$rpart, main="Decision Tree merged $ Quintiles")

#============================================================
# Rattle timestamp: 2017-02-24 00:15:18 x86_64-w64-mingw32 

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
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-24 00:15:54 x86_64-w64-mingw32 

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
     "PCT_CVD_death")

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

crs$categoric <- NULL

crs$target  <- "Quintiles"
crs$risk    <- NULL
crs$ident   <- NULL
crs$ignore  <- c("Areaname", "STCOU", "ageadjustedrate")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2017-02-24 00:15:58 x86_64-w64-mingw32 

# Random Forest 

# The 'randomForest' package provides the 'randomForest' function.

library(randomForest, quietly=TRUE)

# Build the Random Forest model.

set.seed(crv$seed)
crs$rf <- randomForest::randomForest(Quintiles ~ .,
      data=crs$dataset[crs$sample,c(crs$input, crs$target)], 
      ntree=500,
      mtry=8,
      importance=TRUE,
      na.action=randomForest::na.roughfix,
      replace=FALSE)

#============================================================
# Rattle timestamp: 2017-02-24 00:17:27 x86_64-w64-mingw32 

# CLEANUP the Dataset 

#============================================================
# Rattle timestamp: 2017-02-24 00:17:34 x86_64-w64-mingw32 

# CLEANUP the Dataset 
