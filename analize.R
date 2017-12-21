library(readr)
rm(df)
df <- read.csv("C:/Neat/Study/конструкции/data.csv", sep=";", encoding="utf-8")

#логистическая регрессия-------------------------------------

fit <- glm(target~Literal+Question+Negation+VerbTalk,data=df,family=binomial)
summary(fit) # display results

#корреляция переменных---------------------------------------
library('corrplot')
sub_df = subset(df, select = -c(target) )
corrmatr <- cor(sub_df)
res1 <- cor.mtest(sub_df, conf.level = .99)
corrplot(corrmatr, p.mat = res1$p, insig = "blank")

#случайный лес-----------------------------------------------
library("randomForest")
require(randomForest)
fit <- randomForest(factor(target)~., data=df, importance = TRUE)
importance(fit)
varImpPlot(fit,type=2)

