library(readr)
rm(df)
df <- read.csv("C:/Neat/Study/конструкции/data.csv", sep=";", encoding="utf-8")

#корреляция переменных-------------------------------------------------
library('corrplot')
sub_df = subset(df, select = -c(target) )
corrmatr <- cor(sub_df)
corr_mtest <- cor.mtest(sub_df, conf.level = .99)
corrplot(corrmatr, p.mat = corr_mtest$p, insig = "blank")

#случайный лес---------------------------------------------------------
library("randomForest")
require(randomForest)
fit_forest <- randomForest(factor(target)~., data=df, importance = TRUE)
importance(fit_forest)
varImpPlot(fit_forest, type=2) #plot MeanDecreaseGini

#дерево решений---------------------------------------------------------
library(caTools)
set.seed(3000)
split <- sample.split(df$target, SplitRatio = 0.7)
Train <- subset(df, split == TRUE)
Test <- subset(df, split == FALSE)

library(rpart)
library(rpart.plot)

Tree <- rpart(target ~ Literal+Question+Negation+VerbTalk,
                     data = Train, method = "class",
                     control=rpart.control(minbucket = 25))

prp(Tree) # Простое графическое изображение

#предсказания
PredictCART <- predict(Tree, newdata = Test, type="class")

# точность
table(Test$target, PredictCART)

#логистическая регрессия-------------------------------------------

#одним словом vs. два слова о

rm(df_subset)
df_subset <- read.csv("C:/Neat/Study/конструкции/data_subset.csv", sep=";", encoding="utf-8")

#все переменные
fit_logit <- glm(target ~ Literal+Question+Negation+VerbTalk, data=df_subset, family=binomial)
summary(fit_logit)

#Literal+VerbTalk
fit_logit_important <- glm(target ~ Literal+VerbTalk, data=df_subset, family=binomial)
summary(fit_logit_important)

