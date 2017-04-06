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
