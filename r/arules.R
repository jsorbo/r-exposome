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
