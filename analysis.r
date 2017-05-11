setwd("...")
library(ggplot2)
library(corrgram)
df <- read.csv('homework_example_data.csv', header=TRUE, stringsAsFactors = FALSE)
names(df) <- gsub('.', '', names(df), fixed = TRUE)

df$XNewSessions <- gsub('%', '', df$XNewSessions, fixed = TRUE)
df$EcommerceConversionRate <- gsub('%', '', df$EcommerceConversionRate, fixed=TRUE)
df$BounceRate <- gsub('%', '', df$BounceRate, fixed=TRUE)
df$EcommerceConversionRate <- as.numeric(df$EcommerceConversionRate)
df$XNewSessions <- as.numeric(df$XNewSessions)
df$EcommerceConversionRate <- as.numeric(df$EcommerceConversionRate)
df$BounceRate <- as.numeric(df$BounceRate)

table(nchar(as.character(df$AvgSessionDuration)))

df$AvgSessionDuration <- ifelse(nchar(df$AvgSessionDuration) == 7,
                                df$AvgSessionDuration,
                                substr(df$AvgSessionDuration, 3, nchar(df$AvgSessionDuration)))

df$AvgSessionMinutes <- as.numeric(substr(df$AvgSessionDuration, 3,4))+ 
    as.numeric(substr(df$AvgSessionDuration, 6,7))/60


ggplot(df, aes(x=PagesSession, y=EcommerceConversionRate)) + geom_jitter()
ggplot(df[df$XNewSessions<100,], aes(x=XNewSessions, y=PagesSession)) + geom_jitter()
ggplot(df[df$EcommerceConversionRate>.1 & df$AvgSessionMinutes < 10,], 
       aes(x=AvgSessionMinutes, y=EcommerceConversionRate))+geom_jitter(aes(fill=BounceRate))
