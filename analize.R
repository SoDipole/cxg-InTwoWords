library(readr)
rm(df)
df <- read.csv("C:/Neat/Study/конструкции/data.csv", sep=";", encoding="utf-8")

#корреляция переменных---------------------------------------
library('corrplot')
sub_df = subset(df, select = -c(target) )
corrmatr <- cor(sub_df)
corr_mtest <- cor.mtest(sub_df, conf.level = .99)
corrplot(corrmatr, p.mat = corr_mtest$p, insig = "blank")

#случайный лес-----------------------------------------------
library("randomForest")
require(randomForest)
fit_forest <- randomForest(factor(target)~., data=df, importance = TRUE)
importance(fit_forest)
varImpPlot(fit_forest, type=2) #plot MeanDecreaseGini

#логистическая регрессия-------------------------------------
df_new <- df
df_new[,'Literal']<- as.factor(data[,'Literal'])
df_new[,'Question']<- as.factor(data[,'Question'])
df_new[,'Negation']<- as.factor(data[,'Negation'])
df_new[,'VerbTalk']<- as.factor(data[,'VerbTalk'])

fit_logit <- glm(target ~ Literal+Question+Negation+VerbTalk, data=df_new, family=binomial)
summary(fit_logit)

logit_pred = predict(fit_logit, type='response')