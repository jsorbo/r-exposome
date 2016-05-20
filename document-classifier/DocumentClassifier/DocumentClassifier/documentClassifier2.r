# init

libs <- c("tm", "plyr", "class")
lapply(libs, require, character.only = TRUE)

options(stringsAsFactors = FALSE)

candidates <- c("romney", "obama")
baseDirectory <- "c://jsorbo/repos/statistics/document-classifier/DocumentClassifier/DocumentClassifier/"
pathname <- paste(c(baseDirectory, "speeches/"), collapse = "")

# clean text

cleanCorpus <- function(corpus) {
    corpus.tmp <- tm_map(corpus, removePunctuation)
    corpus.tmp <- tm_map(corpus.tmp, stripWhitespace)
    corpus.tmp <- tm_map(corpus.tmp, content_transformer(tolower))
    corpus.tmp <- tm_map(corpus.tmp, removeWords, stopwords("english"))
    return(corpus.tmp)
}

# build TDM

generateTdm <- function(cand, path) {
    s.dir <- sprintf("%s/%s", path, cand)
    s.cor <- Corpus(DirSource(directory = s.dir, encoding = "UTF-8"))
    s.cor.cl <- cleanCorpus(s.cor)
    s.tdm <- TermDocumentMatrix(s.cor.cl)
    s.tdm <- removeSparseTerms(s.tdm, 0.7)
    result <- list(name = cand, tdm = s.tdm)
}

tdm <- lapply(candidates, generateTdm, path = pathname)

# attach name

bindCandidateToTdm <- function(tdm) {
    s.mat <- t(data.matrix(tdm[["tdm"]]))
    s.df <- as.data.frame(s.mat, stringsAsFactors = FALSE)
    s.df <- cbind(s.df, rep(tdm[["name"]], nrow(s.df)))
    colnames(s.df)[ncol(s.df)] <- "targetCandidate"
    return(s.df)
}

candTdm <- lapply(tdm, bindCandidateToTdm)

str(candTdm)

# stack

tdm.stack <- do.call(rbind.fill, candTdm)
tdm.stack[is.na(tdm.stack)] <- 0

head(tdm.stack)
nrow(tdm.stack)
ncol(tdm.stack)

# hold-out

train.idx <- sample(nrow(tdm.stack), ceiling(nrow(tdm.stack) * 0.7))
test.idx <- (1:nrow(tdm.stack))[ - train.idx]

head(train.idx)
head(test.idx)

# model - kNN

tdm.cand <- tdm.stack[, "targetCandidate"]
tdm.stack.nl <- tdm.stack[, !colnames(tdm.stack) %in% "targetCandidate"]
knn.pred <- knn(tdm.stack.nl[train.idx, ], tdm.stack.nl[test.idx, ], tdm.cand[train.idx])

# accuracy

conf.mat <- table("Predictions" = knn.pred, Actual = tdm.cand[test.idx])

conf.mat

accuracy <- sum(diag(conf.mat) / length(test.idx) * 100)

accuracy