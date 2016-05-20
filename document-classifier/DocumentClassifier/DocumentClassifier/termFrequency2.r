# https://deltadna.com/blog/text-mining-in-r-for-term-frequency/
# slight adaptation for text files

# init

library(tm)

options(stringsAsFactors = FALSE)

baseDirectory <- "c://jsorbo/repos/statistics/document-classifier/DocumentClassifier/DocumentClassifier/"
pathname <- paste(c(baseDirectory, "data/"), collapse = "")
setwd(pathname)

# read csv

document <- read.delim("MobyDick.txt", header = FALSE, sep = " ", quote = "")

str(document)

# paste lines together

document_text <- paste(document, collapse = " ")

document_text

# set up source

document_source <- VectorSource(document_text)
corpus <- Corpus(document_source)

str(corpus)

# begin cleaning the text

corpus <- cleanCorpus(corpus)

stopwords("english")

# create document-term matrix

dtm <- DocumentTermMatrix(corpus)

dtm2 <- as.matrix(dtm)

frequency <- colSums(dtm2)

frequency <- sort(frequency, decreasing = TRUE)

head(frequency)

# plot a word cloud

install.packages("wordcloud")

library(wordcloud)

words <- names(frequency)

wordcloud(words[1:100], frequency[1:100])

