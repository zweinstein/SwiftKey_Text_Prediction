## Context-based Word Prediction for Most Common English Words
## based on previously calculated ngram frequencies.

## ----------
# The script reads a text input, matches the last N-1 input words
# to the N-gram (N decreases from 6 to 2), and predicts the most likely
# next word based on N-gram frequencies.

# The N-grams (N=1:6) were previously calculated with Quanteda text mining package.
# The save file size and search time on the App, all the words are stored in N-gram
# files by their index (integer, instead of characters) in the unigram file. The 
# whole N-grams collection contains 98% of all the single words that appeared in 
# 1.6 millions of sentences collected from Twitter, blogs, and news in English
# language, which were 20% of random samples from the Coursera Swiftkey text datasets. 
# The structure of the N-gram data tables are: e.g. for 4-grams (4 words per record)
# <pred1> <pred2> <pred3> <word> .

## ----------

## Load in N-grams 
if (!exists("g1w")) {
  g1w <- readRDS("data/g1w.RData")
}

if (!exists("g2w3")) {
  g2w3 <- readRDS("data/g2w3.RData")
}

if (!exists("g3w3")) {
  g3w3 <- readRDS("data/g3w3.RData")
}

if (!exists("g4w3")) {
  g4w3 <- readRDS("data/g4w3.RData")
}

if (!exists("g5w3")) {
  g5w3 <- readRDS("data/g5w3.RData")
}

if (!exists("g6w3")) {
  g6w3 <- readRDS("data/g6w3.RData")
}

## Clean Text
CleanText <- function(x) {
  # convert to lowercase
  x <- tolower(x)
  # remove punctuation, except intra-word apostrophe and dash
  x <- gsub("[^[:alnum:][:space:]'-]", " ", x)
  # x <- gsub("[^a-zA-Z0-9'-]", " ", x)
  # remove lone numbers,apostrophe and dash
  x <- gsub("\\s[0-9'-]+\\s", " ", x)
  x <- unlist(strsplit(x, "\\s+"))
  return(x)
}

## Get the last N-1 words from cleaned text as their indeices in the unigram list
IndexLastWords <- function(clean) {
  index <- match(clean, g1w)
  index <- index[!is.na(index)]
  n <- length(index)
  if (n > 5) {
    index <- index[(n-4):n]
  }
  return(index)
}

## Check N-grams (N=1:6) for next word prediction

MatchPredict <- function(clean) {
  ix <- IndexLastWords(clean) # length(ix) >=1
  n = length(ix) +1
  if (n > 1) {
    words <- integer()
    for (k in n:2) {
      gram <- get(paste0("g",k, "w3"))
      for (i in 1:(k-1)) {
        name <- paste0("pred", i)
        gram <- subset(gram, get(name)==ix[i])
      }
      words <- unique(c(words, gram$word))
      # words <- c(words, gram$word)
      if (length(words) > 2) {
        return(g1w[words[1:3]])
      }
      k = k-1
      ix <- ix[-1]
    }
    if (length(words) < 3) {
      words <- unique(c(words, c(1,2,3)))
      return(g1w[words[1:3]])
    }
  }
  return(c("i", "the", "it"))
} 


