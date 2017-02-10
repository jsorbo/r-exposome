install.packages("mongolite")

library(mongolite)

AllIndependentVariables <- mongo(db = "exposome", collection = "AllIndependentVariables")
CensusCodeBook <- mongo(db = "exposome", collection = "CensusCodeBook")
CvdPercentilePoints <- mongo(db = "exposome", collection = "CvdPercentilePoints")
DependentVariableAgeAdjusted <- mongo(db = "exposome", collection = "DependentVariableAgeAdjusted")
DependentVariableByAgeCategory <- mongo(db = "exposome", collection = "DependentVariableByAgeCategory")
IndependentPercentilePoints <- mongo(db = "exposome", collection = "IndependentPercentilePoints")

AllIndependentVariables$find()
CensusCodeBook$find()
CvdPercentilePoints$find()
DependentVariableAgeAdjusted$find()
DependentVariableByAgeCategory$find()
IndependentPercentilePoints$find()
