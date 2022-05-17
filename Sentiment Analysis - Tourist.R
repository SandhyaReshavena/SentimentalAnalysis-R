# Requried Packages:"tm","syuzhet","wordcloud","topicmodels"
library(tm);library(syuzhet);library(wordcloud);library(topicmodels)
# import data set
data = read.csv('tourist_accommodation_reviews.csv');head(data, n=2)
data1 = data$Review;head(data1, n=2)
# Pre-processing - cleaning the unnecessary text
data1 = gsub('(RT|via)((?:\\b\\W*@\\w+)+)', '', data1) # remove retweet
data1 = gsub('@\\w+', '', data1) # remove @ people
data1 = gsub('[[:punct:]]', '', data1) # remove punctuation
data1 = gsub('[[:digit:]]', '', data1) # remove Numbers
data1 = gsub('http\\w+', '', data1) # remove html links
data1 = gsub('[ \t]{2,}', '', data1) # remove unnecessary spaces
data1 = gsub('^\\s+|\\s+$', '', data1) # remove spaces
data1= gsub('\n','',data1) # remove \n
data1= gsub(',','',data1) # remove comma
head(data1,n=3)
#data1=iconv(data1,to="utf-8-mac")
data1=tolower(data1) # convert the text to lower case
sentiment=get_nrc_sentiment(data1) # Sentiments
head(sentiment)
barplot(sort(colSums(prop.table(sentiment))), horiz = TRUE,cex.names = 0.7,
las = 1, main = "Emotions in tourist accomodation review", xlab="Percentage",
xlim = c(0,0.20))

datacorpus=Corpus(VectorSource(data1)) # Generating combinations of words with all the sentiments in it
head(datacorpus)
datacorpus=tm_map(datacorpus, function(x) removeWords(x,stopwords())) # removing stopwords (Daily usage words from the text eg: the, my, you etc.)
wordcloud(datacorpus,min.freq = 1,colors=brewer.pal(8, "Dark2"),max.words =100) # Generating wordcloud with all the emotions reported in the review in form of sentiment


