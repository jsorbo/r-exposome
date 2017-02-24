install.packages("mongolite")

library(mongolite)

# Connect to MongoDB collections

AllIndependentVariables <- mongo(db = "exposome", collection = "AllIndependentVariables")
CensusCodeBook <- mongo(db = "exposome", collection = "CensusCodeBook")
CvdPercentilePoints <- mongo(db = "exposome", collection = "CvdPercentilePoints")
DependentVariableAgeAdjusted <- mongo(db = "exposome", collection = "DependentVariableAgeAdjusted")
DependentVariableByAgeCategory <- mongo(db = "exposome", collection = "DependentVariableByAgeCategory")
IndependentPercentilePoints <- mongo(db = "exposome", collection = "IndependentPercentilePoints")
QuintilesForPctCvd <- mongo(db = "exposome", collection = "QuintilesForPctCvd")

# Retrieve all fields from each collection

independent <- AllIndependentVariables$find()
CensusCodeBook$find()
CvdPercentilePoints$find()
DependentVariableAgeAdjusted$find()
DependentVariableByAgeCategory$find()
IndependentPercentilePoints$find()
dependentQuintiles <- QuintilesForPctCvd$find()

renameColumn <- function(dataFrame, from, to) {
  names(dataFrame)[names(dataFrame) == from] <- to
  return(dataFrame)
}

independent <- AllIndependentVariables$find()

independent <- renameColumn(independent, "AGE030200D", "populationApril2000")
independent <- renameColumn(independent, "AGE040200D", "populationJuly2000")
independent <- renameColumn(independent, "AGE050200D", "populationMedianAgeApril2000")
independent <- renameColumn(independent, "BNK010200D", "bankOfficesJune2000")
independent <- renameColumn(independent, "BNK050200D", "bankDepositsJune2000")
independent <- renameColumn(independent, "CLF030200D", "unemployment")
independent <- renameColumn(independent, "CLF040200D", "unemploymentRate")
independent <- renameColumn(independent, "CRM110200D", "violentCrimes")
independent <- renameColumn(independent, "EDU635200D", "educationHighSchoolOrAboveRate")
independent <- renameColumn(independent, "HEA010200D", "insuranceOrMedicare")
independent <- renameColumn(independent, "HEA070200D", "medicare")
independent <- renameColumn(independent, "HSD150200D", "householdsMaleNoWife")
independent <- renameColumn(independent, "HSD170200D", "householdsFemaleNoHusband")
independent <- renameColumn(independent, "HSG455200D", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican")
independent <- renameColumn(independent, "HSG460200D", "ownerOccupiedHomesHouseholderHispanicOrLatino")
independent <- renameColumn(independent, "HSG495200D", "sampleMedianHousingUnitValue")
independent <- renameColumn(independent, "HSG680200D", "renterOccupiedHousingUnits")
independent <- renameColumn(independent, "HSG695200D", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican")
independent <- renameColumn(independent, "HSG700200D", "renterOccupiedHomesHouseholderHispanicOrLatino")
independent <- renameColumn(independent, "INC110199D", "medianHouseholdIncome1999")
independent <- renameColumn(independent, "INC415199D", "meanHouseholdEarnings")
independent <- renameColumn(independent, "INC420200D", "householdsWithSocialSecurityIncome")
independent <- renameColumn(independent, "INC910199D", "perCapitaIncome")
independent <- renameColumn(independent, "IPE010200D", "medianHouseholdIncome2000")
independent <- renameColumn(independent, "IPE120200D", "peopleInPovertyRate")
independent <- renameColumn(independent, "LND110200D", "landArea")
independent <- renameColumn(independent, "PIN020200D", "perCapitaPersonalIncome")
independent <- renameColumn(independent, "POP060200D", "populationPerSquareMile")
independent <- renameColumn(independent, "POP110200D", "urbanPopulationSample")
independent <- renameColumn(independent, "POP150200D", "malePopulationCompleteCount")
independent <- renameColumn(independent, "POP160200D", "femalePopulationCompleteCount")
independent <- renameColumn(independent, "POP220200D", "populationOfOneRaceWhiteAloneCompleteCount")
independent <- renameColumn(independent, "POP250200D", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount")
independent <- renameColumn(independent, "PVY020199D", "populationBelowPovertyLevel")
independent <- renameColumn(independent, "SPR010200D", "socialSecurityBenefitRecipients")
independent <- renameColumn(independent, "SPR410200D", "supplementalSecurityIncomeRecipients")

# Convert to numeric

independent["medianHouseholdIncome2000"] <- lapply(independent["medianHouseholdIncome2000"], as.numeric)
independent["peopleInPovertyRate"] <- lapply(independent["peopleInPovertyRate"], as.numeric)
independent["insuranceOrMedicare"] <- lapply(independent["insuranceOrMedicare"], as.numeric)
independent["violentCrimes"] <- lapply(independent["violentCrimes"], as.numeric)
independent["perCapitaPersonalIncome"] <- lapply(independent["perCapitaPersonalIncome"], as.numeric)
independent["educationHighSchoolOrAboveRate"] <- lapply(independent["educationHighSchoolOrAboveRate"], as.numeric)
independent["populationPerSquareMile"] <- lapply(independent["populationPerSquareMile"], as.numeric)
independent["urbanPopulationSample"] <- lapply(independent["urbanPopulationSample"], as.numeric)
independent["malePopulationCompleteCount"] <- lapply(independent["malePopulationCompleteCount"], as.numeric)
independent["femalePopulationCompleteCount"] <- lapply(independent["femalePopulationCompleteCount"], as.numeric)
independent["populationOfOneRaceWhiteAloneCompleteCount"] <- lapply(independent["populationOfOneRaceWhiteAloneCompleteCount"], as.numeric)
independent["populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount"] <- lapply(independent["populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount"], as.numeric)
independent["renterOccupiedHousingUnits"] <- lapply(independent["renterOccupiedHousingUnits"], as.numeric)
independent["renterOccupiedHomesHouseholderBlackOrAfricanAmerican"] <- lapply(independent["renterOccupiedHomesHouseholderBlackOrAfricanAmerican"], as.numeric)
independent["renterOccupiedHomesHouseholderHispanicOrLatino"] <- lapply(independent["renterOccupiedHomesHouseholderHispanicOrLatino"], as.numeric)
independent["householdsMaleNoWife"] <- lapply(independent["householdsMaleNoWife"], as.numeric)
independent["householdsFemaleNoHusband"] <- lapply(independent["householdsFemaleNoHusband"], as.numeric)
independent["socialSecurityBenefitRecipients"] <- lapply(independent["socialSecurityBenefitRecipients"], as.numeric)
independent["supplementalSecurityIncomeRecipients"] <- lapply(independent["supplementalSecurityIncomeRecipients"], as.numeric)
independent["landArea"] <- lapply(independent["landArea"], as.numeric)
independent["unemploymentRate"] <- lapply(independent["unemploymentRate"], as.numeric)
independent["bankOfficesJune2000"] <- lapply(independent["bankOfficesJune2000"], as.numeric)
independent["AvgFineParticulateMatterµgm"] <- lapply(independent["AvgFineParticulateMatterµgm"], as.numeric)
independent["AvgDailyPrecipitationmm"] <- lapply(independent["AvgDailyPrecipitationmm"], as.numeric)
independent["AvgDayLandSurfaceTemperatureF"] <- lapply(independent["AvgDayLandSurfaceTemperatureF"], as.numeric)
independent["AvgDailyMaxAirTemperatureF"] <- lapply(independent["AvgDailyMaxAirTemperatureF"], as.numeric)
independent["AvgDailyMinAirTemperatureF"] <- lapply(independent["AvgDailyMinAirTemperatureF"], as.numeric)
independent["AvgDailyMaxHeatIndexF"] <- lapply(independent["AvgDailyMaxHeatIndexF"], as.numeric)
independent["populationApril2000"] <- lapply(independent["populationApril2000"], as.numeric)
independent["populationJuly2000"] <- lapply(independent["populationJuly2000"], as.numeric)
independent["b_1996"] <- lapply(independent["b_1996"], as.numeric)
independent["b_1997"] <- lapply(independent["b_1997"], as.numeric)
independent["b_1998"] <- lapply(independent["b_1998"], as.numeric)
independent["b_1999"] <- lapply(independent["b_1999"], as.numeric)
independent["b_2000"] <- lapply(independent["b_2000"], as.numeric)
independent["averagesmoke1996to2000"] <- lapply(independent["averagesmoke1996to2000"], as.numeric)
independent["populationMedianAgeApril2000"] <- lapply(independent["populationMedianAgeApril2000"], as.numeric)
independent["number2004diabetes"] <- lapply(independent["number2004diabetes"], as.numeric)
independent["percent2004diabetes"] <- lapply(independent["percent2004diabetes"], as.numeric)
independent["ageadjustedpercent2004diabetes"] <- lapply(independent["ageadjustedpercent2004diabetes"], as.numeric)
independent["ownerOccupiedHomesHouseholderBlackOrAfricanAmerican"] <- lapply(independent["ownerOccupiedHomesHouseholderBlackOrAfricanAmerican"], as.numeric)
independent["ownerOccupiedHomesHouseholderHispanicOrLatino"] <- lapply(independent["ownerOccupiedHomesHouseholderHispanicOrLatino"], as.numeric)
independent["sampleMedianHousingUnitValue"] <- lapply(independent["sampleMedianHousingUnitValue"], as.numeric)
independent["perCapitaIncome"] <- lapply(independent["perCapitaIncome"], as.numeric)
independent["numberobesityprevalence2004"] <- lapply(independent["numberobesityprevalence2004"], as.numeric)
independent["percentobesity2004"] <- lapply(independent["percentobesity2004"], as.numeric)
independent["ageadjustedpercentobesity2004"] <- lapply(independent["ageadjustedpercentobesity2004"], as.numeric)
independent["numberleisuretimephysicalinactivityprevalence2004"] <- lapply(independent["numberleisuretimephysicalinactivityprevalence2004"], as.numeric)
independent["percentleisuretimephysicalinactivityprevalence2004"] <- lapply(independent["percentleisuretimephysicalinactivityprevalence2004"], as.numeric)
independent["ageadjustedpercentleisuretimephysicalinactivityprevalence2004"] <- lapply(independent["ageadjustedpercentleisuretimephysicalinactivityprevalence2004"], as.numeric)
independent["HHNV1MI"] <- lapply(independent["HHNV1MI"], as.numeric)
independent["FFRPTH07"] <- lapply(independent["FFRPTH07"], as.numeric)
independent["FSRPTH07"] <- lapply(independent["FSRPTH07"], as.numeric)
independent["PH_FRUVEG"] <- lapply(independent["PH_FRUVEG"], as.numeric)
independent["PH_SNACKS"] <- lapply(independent["PH_SNACKS"], as.numeric)
independent["PH_SODA"] <- lapply(independent["PH_SODA"], as.numeric)
independent["PH_MEAT"] <- lapply(independent["PH_MEAT"], as.numeric)
independent["PH_FATS"] <- lapply(independent["PH_FATS"], as.numeric)
independent["PH_PREPFOOD"] <- lapply(independent["PH_PREPFOOD"], as.numeric)
independent["medicare"] <- lapply(independent["medicare"], as.numeric)

# Remove na

independent = independent[complete.cases(independent),]

names(independent)
independent

# Retrieve fields from dependent quintiles

dependentQuintiles <- QuintilesForPctCvd$find()

# Remove ' County' substring from County field

dependentQuintiles["County"] <- lapply(dependentQuintiles["County"], gsub, pattern = " County", replacement = "", fixed = TRUE)

# Join independent with dependent quintiles

merged <- merge(x=independent, y=dependentQuintiles, by.x="Areaname", by.y=gsub(" County", "", "County"))

# Projection from joined dataframes

d = subset(merged, select=c(
  "ageadjustedpercent2004diabetes", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", 
  "unemploymentRate", "educationHighSchoolOrAboveRate", "perCapitaPersonalIncome",
  "AvgDailyMinAirTemperatureF", "AvgDailyMaxHeatIndexF",
  "Quintiles"))

# Convert to numeric

d["ageadjustedpercent2004diabetes"] <- lapply(d["ageadjustedpercent2004diabetes"], as.numeric)
d["ageadjustedpercentleisuretimephysicalinactivityprevalence2004"] <- lapply(d["ageadjustedpercentleisuretimephysicalinactivityprevalence2004"], as.numeric)
d["Quintiles"] <- lapply(d["Quintiles"], as.numeric)
d["unemploymentRate"] <- lapply(d["unemploymentRate"], as.numeric)
d["educationHighSchoolOrAboveRate"] <- lapply(d["educationHighSchoolOrAboveRate"], as.numeric)
d["perCapitaPersonalIncome"] <- lapply(d["perCapitaPersonalIncome"], as.numeric)
d["AvgDailyMinAirTemperatureF"] <- lapply(d["AvgDailyMinAirTemperatureF"], as.numeric)
d["AvgDailyMaxHeatIndexF"] <- lapply(d["AvgDailyMaxHeatIndexF"], as.numeric)


# Remove na

d = d[complete.cases(d),]

