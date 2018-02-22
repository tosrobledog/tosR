

#  Creando el ambiente 

setwd("C:/Users/unalman/Downloads")

library(bibliometrix)

#  Adquiriendo los datos

tos.1 <- readFiles("savedrecs.txt")
class(tos.1)

tos.2 <- convert2df(tos.1)


y <- data.frame(table(tos.2$PY), stringsAsFactors = FALSE)
plot(y)
plot(y$Freq, type = "l")



# nube de palabras

df.tos.1 <- paste(tos.2$TI, tos.2$AB, tos.2$DE, sep = " ")
View(df.tos.1)

library(tm)

myCorpus <- Corpus(VectorSource(df.tos.1))

myCorpus = tm_map(myCorpus, tolower)
myCorpus = tm_map(myCorpus, removePunctuation)
myCorpus = tm_map(myCorpus, removeNumbers)
myCorpus = tm_map(myCorpus, removeWords, stopwords("english"))


myDTM = TermDocumentMatrix(myCorpus, 
                           control = list(minWordLength = 1))

m = as.matrix(myDTM)

v = sort(rowSums(m), decreasing = TRUE)

library(wordcloud)
set.seed(4363)
wordcloud(names(v), v, min.freq = 10)