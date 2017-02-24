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
QuintilesForPctCvd$find()

# Retrieve fields from independent variables

query <- '{"Areaname": { "$ne": "UNITED STATES"}}'
projectionString <- '{"Areaname": 1, 
"ageadjustedpercent2004diabetes": 1, 
"ageadjustedpercentleisuretimephysicalinactivityprevalence2004": 1 }'
projection <- strwrap(projectionString, width=10000, simplify=TRUE)

independent <- AllIndependentVariables$find(query)#, projection)

names(independent)

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

# Retrieve fields from dependent variable

query <- '{"Areaname": { "$ne": "UNITED STATES"}, "ageadjustedrate": { "$ne": "(Unreliable)"}}'
projectionString <- '{"County": 1, 
"ageadjustedrate": 1 }'
projection <- strwrap(projectionString, width=10000, simplify=TRUE)

dependent <- DependentVariableAgeAdjusted$find(query)#, projection)

# Remove ' County' substring from County field

dependent["County"] <- lapply(dependent["County"], gsub, pattern = " County", replacement = "", fixed = TRUE)

# Retrieve fields from dependent quintiles

query <- '{"ageadjustedrate": {"$ne": "(Unreliable)"}, "Quintiles": { "$ne": "na"}}'
projectionString <- '{"County": 1, 
"Quintiles": 1 }'
projection <- strwrap(projectionString, width=10000, simplify=TRUE)

dependentQuintiles <- QuintilesForPctCvd$find(query)#, projection)

# Remove ' County' substring from County field

dependentQuintiles["County"] <- lapply(dependent["County"], gsub, pattern = " County", replacement = "", fixed = TRUE)

# Join independent with dependent quintiles

merged <- merge(x=independent, y=dependentQuintiles, by.x="Areaname", by.y=gsub(" County", "", "County"))

# Projection from joined dataframes

d = subset(merged, select=c("ageadjustedpercent2004diabetes", "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "Quintiles"))

# Convert to numeric

d["ageadjustedpercent2004diabetes"] <- lapply(d["ageadjustedpercent2004diabetes"], as.numeric)
d["ageadjustedpercentleisuretimephysicalinactivityprevalence2004"] <- lapply(d["ageadjustedpercentleisuretimephysicalinactivityprevalence2004"], as.numeric)
d["Quintiles"] <- lapply(d["Quintiles"], as.numeric)

# Rename fields

colnames(d) <- c("diabetes", "inactivity", "quintile")

# Remove na

d = d[complete.cases(d),]

