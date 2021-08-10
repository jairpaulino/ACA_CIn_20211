#Title: Classificadores baseado em regressão logística, lógica bayesiana e k-nn
#Author: Jair Paulino
#Date: 2021/Ago/10

# Inicializacao ----
# limpar dados e figuras
rm(list = ls()); graphics.off()

# Bibliotecas
library(caTools)   #sample.split
library(e1071)     #naiveBayes
library(caret)     #confusionMatrix
library(MLmetrics) #metrics
library(class)     #knn
library(dplyr)     #dados
library(reshape2)  #dados
library(cvTools)   #cv tools
library(rpart)     #DT
library(rpart.plot)#DR

# Importar funcoes implementadas
#source("Codes/auxiliar.R")
source("R/modelsAM_cv.R")

# FASE 1 - Pre-processamento ----

# Importar dados
data = read.csv("Data/data_banknote_authentication.csv", sep = ";")
data$class = factor(data$class, levels = c(0, 1))

# Normalizar dados
dataNorm = as.data.frame(sapply(data[,1:4], FUN = normalize_2))
dataNorm$class = data$class

# Separar em conjunto de validacao (20%)
set.seed(1123)
sample = sample.split(dataNorm$vwti, SplitRatio = 0.8)
dataNormValid = subset(dataNorm, sample == F)
dataNormTrain = subset(dataNorm, sample == T)
dataValid = subset(data, sample == F)

# M1 - Regressão Logística (RL)
modelLR = getRL_cv(train = data,
                   exportResults = T)

# Resultados RL 
modelLR$Metrics
modelLR$IC
modelLR$Results

# M2 - Classificador bayesiano gaussiano (CBG)
modelCGB = getCBG_cv(train_df = data,
                     exportResults = TRUE)
# Resultados CBG 
modelCGB$Metrics
modelCGB$IC
modelCGB$Results

# M3 - CBG baseado em K-vizinhos (CBG-kNN)
modelKNN = getKNN_cv(train_df = dataNorm, 
                     valid_df = dataNormValid,
                     exportResults = T)
# Resultados KNN 
modelKNN$Metrics
modelKNN$IC
modelKNN$Results

# Resultados
classResult = data.frame(matrix(ncol=4, nrow=length(dataNorm$class)))
colnames(classResult) = c('Class', 'LR', 'CBG', 'KNN')
classResult$Class = dataNorm$class
classResult$CBG = modelCGB$Results[,2]
classResult$KNN = modelKNN$Results[,2]
classResult$LR = modelLR$Results[,2]
#View(classResult)

write.csv(classResult, file = "Results/classResult.csv")

# FASE 3 - Analise dos resultados ----
metricTable = data.frame(matrix(ncol=4, nrow=3))
colnames(metricTable) = c('ErroRate', 'Precisão', 'Recall', 'F1-measure')
rownames(metricTable) = c('LR', 'CBG', 'KNN')
metricTable[1,1:4] = colMeans(modelLR$Metrics)
metricTable[2,1:4] = colMeans(modelCGB$Metrics)
metricTable[3,1:4] = colMeans(modelKNN$Metrics)
metricTable$ErroRate = NULL
View(metricTable)

# jpeg(file = "Results/generalResults.jpeg", width = 1200, height = 800, res = 150, quality=100 )
counts = as.matrix(metricTable[c(-5)])
barplot(counts,
        xlab="Metrics",
        ylim = c(0,1.2),
        col=c(gray.colors(6)),
        beside = TRUE)
legend('top', 95, legend=c("LR", "CG", "KNN"),
       col=c(gray.colors(6)), pch=15, cex=0.8, horiz = T)
# dev.off()

# Questão 3 ----

# Ajusta o modelo DT
fit = rpart(formula = dataNormTrain$class ~ ., 
            data = dataNormTrain,
            method = 'class')

# Imprime as variáveis mais importantes
# jpeg(file = "Results/dTImportance.jpeg", width = 1200, height = 800, res = 150, quality=100 )
barplot(fit$variable.importance)
# dev.off()

# Imprime a árvore de decisão
# jpeg(file = "Results/dTResults.jpeg", width = 1200, height = 800, res = 150, quality=100 )
rpart.plot(fit, type = 0)
# dev.off()

pred = predict(fit, newdata = dataNormValid, type = 'class')
confusao = table(Original = dataNormValid$class,
                 Predito = pred)

recall = Recall(pred, dataNormValid$class)
f1Score = F1_Score(pred, dataNormValid$class)
precision = Precision(pred, dataNormValid$class)
