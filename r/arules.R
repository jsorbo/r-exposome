# installing/loading the package:
if(!require(installr)) {
  install.packages("installr"); require(installr)} #load / install+load installr

# using the package:
updateR() # this will start the updating process of your R installation.  It will check for newer versions, and if one is available, will guide you through the decisions you'd need to make.

copy.packages.between.libraries()



packageurl <- "https://cran.r-project.org/src/contrib/arules_1.5-2.tar.gz"
install.packages(packageurl, contriburl=NULL, type="source")
install.packages("c:\\r\\arules_1.5-2.tar", repos=NULL, type="source")

install.packages("arulesViz")

library("arules");
library("arulesViz");
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

install.packages(c("arules", "arulesViz"))

library(arules)

filename <- "c:\\jsorbo\\repos\\msseproject\\exposome-data\\arulesdata.csv"
write.csv(arulesdataset, file=filename)
trans = read.transactions(filename, format="basket", sep=",")

attributes(trans)

trans.transactions

patterns = random.patterns(nItems = 1000);
summary(patterns);
trans = random.transactions(nItems = 1000, nTrans = 1000, method = "agrawal",  patterns = patterns);
image(trans);

data("AdultUCI");
Adult = as(AdultUCI, "transactions");
rules = apriori(Adult, parameter=list(support=0.01, confidence=0.5));
rules;
