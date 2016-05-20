# https://deltadna.com/blog/text-mining-in-r-for-term-frequency/

# init

library(tm)

options(stringsAsFactors = FALSE)

baseDirectory <- "c://jsorbo/repos/statistics/document-classifier/DocumentClassifier/DocumentClassifier/"
pathname <- paste(c(baseDirectory, "data/"), collapse = "")
setwd(pathname)

# read csv

reviews <- read.csv("reviews.csv", stringsAsFactors = FALSE)

str(reviews)

# not interested in differences between reviews, so paste them together

review_text <- paste(reviews$text, collapse = " ")

# set up source and create corpus

review_source <- VectorSource(review_text)
corpus <- Corpus(review_source)

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

