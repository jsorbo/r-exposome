# https://deltadna.com/blog/text-mining-in-r-for-term-frequency/
# slight adaptation for text files

# init

install.packages("wordcloud")
library(wordcloud)
library(tm)

options(stringsAsFactors = FALSE)

baseDirectory <- "c://jsorbo/repos/statistics/document-classifier/DocumentClassifier/DocumentClassifier/"
pathname <- paste(c(baseDirectory, "data/"), collapse = "")
setwd(pathname)

# read file

document <- read.delim("BlackBeauty.txt", header = FALSE, sep = " ", quote = "")

# clean corpus

cleanCorpus <- function(corpus) {
    corpus.tmp <- tm_map(corpus, removePunctuation)
    corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
    corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
    corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
    return(corpus.tmp)
}

# generate word cloud

generateWordCloud <- function(document) {
    # paste lines together
    document_text <- paste(document, collapse = " ")

    # create vector source
    document_source <- VectorSource(document_text)

    # create corpus
    corpus <- Corpus(document_source)

    # clean corpus
    corpus <- cleanCorpus(corpus)

    # create doc-term matrix
    dtm <- DocumentTermMatrix(corpus)

    # create regular matrix
    dtm2 <- as.matrix(dtm)

    # find word counts
    frequency <- colSums(dtm2)

    # sort word counts
    frequency <- sort(frequency, decreasing = TRUE)

    # pull list of words
    words <- names(frequency)

    # plot word cloud
    wordcloud(words[1:100], frequency[1:100],colors=c("black", "purple", "blue", "green", "red", "pink"))
}

generateWordCloud(document)
