merged <- convert_vector_of_columns_to_binary(merged, c("b_1999", "b_2000", "averagesmoke1996to2000", "percent2004diabetes",
                                                           "ageadjustedpercent2004diabetes", "percentobesity2004", "ageadjustedpercentobesity2004", 
                                                           "percentleisuretimephysicalinactivityprevalence2004",
                                                           "ageadjustedpercentleisuretimephysicalinactivityprevalence2004", "PH_SODA"))

merged <- convert_vector_of_columns_to_binary(merged, c("educationHighSchoolOrAboveRate", 
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
                                                        "ageadjustedpercent2004diabetes"))

arulesdataset <- convert_quintile_to_binary(merged, "Quintiles")
