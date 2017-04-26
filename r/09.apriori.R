arulesdataset <- arulesdataset[,c("5tile.b_1999.1",
                                  "5tile.b_1999.2",
                                  "5tile.b_1999.3",
                                  "5tile.b_1999.4",
                                  "5tile.b_1999.5",
                                  "5tile.b_2000.1",
                                  "5tile.b_2000.2",
                                  "5tile.b_2000.3",
                                  "5tile.b_2000.4",
                                  "5tile.b_2000.5",
                                  "5tile.averagesmoke1996to2000.1",
                                  "5tile.averagesmoke1996to2000.2",
                                  "5tile.averagesmoke1996to2000.3",
                                  "5tile.averagesmoke1996to2000.4",
                                  "5tile.averagesmoke1996to2000.5",
                                  "5tile.percent2004diabetes.1",
                                  "5tile.percent2004diabetes.2",
                                  "5tile.percent2004diabetes.3",
                                  "5tile.percent2004diabetes.4",
                                  "5tile.percent2004diabetes.5",
                                  "5tile.ageadjustedpercent2004diabetes.1",
                                  "5tile.ageadjustedpercent2004diabetes.2",
                                  "5tile.ageadjustedpercent2004diabetes.3",
                                  "5tile.ageadjustedpercent2004diabetes.4",
                                  "5tile.ageadjustedpercent2004diabetes.5",
                                  "5tile.percentobesity2004.1",
                                  "5tile.percentobesity2004.2",
                                  "5tile.percentobesity2004.3",
                                  "5tile.percentobesity2004.4",
                                  "5tile.percentobesity2004.5",
                                  "5tile.ageadjustedpercentobesity2004.1",
                                  "5tile.ageadjustedpercentobesity2004.2",
                                  "5tile.ageadjustedpercentobesity2004.3",
                                  "5tile.ageadjustedpercentobesity2004.4",
                                  "5tile.ageadjustedpercentobesity2004.5",
                                  "5tile.percentleisuretimephysicalinactivityprevalence2004.1",
                                  "5tile.percentleisuretimephysicalinactivityprevalence2004.2",
                                  "5tile.percentleisuretimephysicalinactivityprevalence2004.3",
                                  "5tile.percentleisuretimephysicalinactivityprevalence2004.4",
                                  "5tile.percentleisuretimephysicalinactivityprevalence2004.5",
                                  "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004.1",
                                  "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004.2",
                                  "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004.3",
                                  "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004.4",
                                  "5tile.ageadjustedpercentleisuretimephysicalinactivityprevalence2004.5",
                                  "5tile.PH_SODA.1",
                                  "5tile.PH_SODA.2",
                                  "5tile.PH_SODA.3",
                                  "5tile.PH_SODA.4",
                                  "5tile.PH_SODA.5",
                                  "Quintiles.1",
                                  "Quintiles.2",
                                  "Quintiles.3",
                                  "Quintiles.4",
                                  "Quintiles.5")]

arulesMatrix <- data.matrix(arulesdataset, rownames.force = FALSE)

trans <- as(arulesMatrix, "transactions")

rules <- apriori(trans, parameter = list(support=0.01, confidence=0.5))

rulesData <- as(rules, "data.frame")

rulesData

write.table(rulesData, file="..\\exposome-data\\arulesData.txt")

inspect(head(sort(rules, by="lift"), 3))

head(quality(rules))
