################################################################################
# 2. load data, rename columns, clean data, merge data frames

# Import from csv

independent <- read.csv(file="..\\exposome-data\\independent.csv", header=TRUE)
dependentQuintiles <- read.csv(file="..\\exposome-data\\dependentQuintiles.csv", header=TRUE)

independent <- rename.column(independent, "AGE030200D", "populationApril2000")
independent <- rename.column(independent, "AGE040200D", "populationJuly2000")
independent <- rename.column(independent, "AGE050200D", "populationMedianAgeApril2000")
independent <- rename.column(independent, "BNK010200D", "bankOfficesJune2000")
independent <- rename.column(independent, "BNK050200D", "bankDepositsJune2000")
independent <- rename.column(independent, "CLF030200D", "unemployment")
independent <- rename.column(independent, "CLF040200D", "unemploymentRate")
independent <- rename.column(independent, "CRM110200D", "violentCrimes")
independent <- rename.column(independent, "EDU635200D", "educationHighSchoolOrAboveRate")
independent <- rename.column(independent, "HEA010200D", "insuranceOrMedicare")
independent <- rename.column(independent, "HEA070200D", "medicare")
independent <- rename.column(independent, "HSD150200D", "householdsMaleNoWife")
independent <- rename.column(independent, "HSD170200D", "householdsFemaleNoHusband")
independent <- rename.column(independent, "HSG455200D", "ownerOccupiedHomesHouseholderBlackOrAfricanAmerican")
independent <- rename.column(independent, "HSG460200D", "ownerOccupiedHomesHouseholderHispanicOrLatino")
independent <- rename.column(independent, "HSG495200D", "sampleMedianHousingUnitValue")
independent <- rename.column(independent, "HSG680200D", "renterOccupiedHousingUnits")
independent <- rename.column(independent, "HSG695200D", "renterOccupiedHomesHouseholderBlackOrAfricanAmerican")
independent <- rename.column(independent, "HSG700200D", "renterOccupiedHomesHouseholderHispanicOrLatino")
independent <- rename.column(independent, "INC110199D", "medianHouseholdIncome1999")
independent <- rename.column(independent, "INC415199D", "meanHouseholdEarnings")
independent <- rename.column(independent, "INC420200D", "householdsWithSocialSecurityIncome")
independent <- rename.column(independent, "INC910199D", "perCapitaIncome")
independent <- rename.column(independent, "IPE010200D", "medianHouseholdIncome2000")
independent <- rename.column(independent, "IPE120200D", "peopleInPovertyRate")
independent <- rename.column(independent, "LND110200D", "landArea")
independent <- rename.column(independent, "PIN020200D", "perCapitaPersonalIncome")
independent <- rename.column(independent, "POP060200D", "populationPerSquareMile")
independent <- rename.column(independent, "POP110200D", "urbanPopulationSample")
independent <- rename.column(independent, "POP150200D", "malePopulationCompleteCount")
independent <- rename.column(independent, "POP160200D", "femalePopulationCompleteCount")
independent <- rename.column(independent, "POP220200D", "populationOfOneRaceWhiteAloneCompleteCount")
independent <- rename.column(independent, "POP250200D", "populationOfOneRaceBlackOrAfricanAmericanAloneCompleteCount")
independent <- rename.column(independent, "PVY020199D", "populationBelowPovertyLevel")
independent <- rename.column(independent, "SPR010200D", "socialSecurityBenefitRecipients")
independent <- rename.column(independent, "SPR410200D", "supplementalSecurityIncomeRecipients")

# Source: ArcGIS REST Services Directory
# https://gis.ers.usda.gov/arcgis/rest/services/fa_restaurants/MapServer/layers
independent <- rename.column(independent, "FFRPTH07", "fastFoodRestaurantsPer1000")
independent <- rename.column(independent, "FSRPTH07", "fullServiceRestaurantsPer1000")

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
independent["fastFoodRestaurantsPer1000"] <- lapply(independent["fastFoodRestaurantsPer1000"], as.numeric)
independent["fullServiceRestaurantsPer1000"] <- lapply(independent["fullServiceRestaurantsPer1000"], as.numeric)
independent["PH_FRUVEG"] <- lapply(independent["PH_FRUVEG"], as.numeric)
independent["PH_SNACKS"] <- lapply(independent["PH_SNACKS"], as.numeric)
independent["PH_SODA"] <- lapply(independent["PH_SODA"], as.numeric)
independent["PH_MEAT"] <- lapply(independent["PH_MEAT"], as.numeric)
independent["PH_FATS"] <- lapply(independent["PH_FATS"], as.numeric)
independent["PH_PREPFOOD"] <- lapply(independent["PH_PREPFOOD"], as.numeric)
independent["medicare"] <- lapply(independent["medicare"], as.numeric)

# Remove na

independent = independent[complete.cases(independent),]

# convert to numeric

dependentQuintiles["ageadjustedrate"] <- lapply(dependentQuintiles["ageadjustedrate"], as.numeric)

# Remove ' County' substring from County field

dependentQuintiles["County"] <- lapply(dependentQuintiles["County"], gsub, pattern = " County", replacement = "", fixed = TRUE)

# Join independent with dependent quintiles

merged <- merge(x=independent, y=dependentQuintiles, by.x="Areaname", by.y=gsub(" County", "", "County"))

# Remove na, null

merged = merged[complete.cases(merged),]

merged <- merged[merged$Quintiles!="#NULL!",]

# group quintiles into two groups
merged$cvd <- sapply(merged$Quintiles, function(x) ifelse(x == "5", "1", "0"))
merged$cvd <- sapply(merged$cvd, as.factor)

