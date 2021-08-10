# M1 - Regressão Logística (RL)
getRL_cv = function(train_df, exportResults = F){
  
  foldIndex = cvFolds(length(train_df$vwti), K = 10, R = 1)
  resultMatrixCV = as.data.frame(matrix(ncol = 4, nrow=10))
  names(resultMatrixCV) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure')
  
  bestModelIndex = 1; bestModelAcc = 100; classAll = NULL
  
  classAll = NULL
  for(i in 1:10){
    set.seed(2311)
    train = train_df[foldIndex$subsets[foldIndex$which != i], ] #Set the training set
    test = train_df[foldIndex$subsets[foldIndex$which == i], ] #Set the validation set
    
    model_lr_cv = glm(class ~ .,
                      data = train,
                      family = binomial(link = 'logit')
    )
    
    
    lr_predict = predict(model_lr_cv, newdata = test[-5])
    lr_predict = ifelse(lr_predict < 0.5, 0, 1)
    lrMetrics = getMetrics(as.numeric(lr_predict), test$class)
    resultMatrixCV[i,] = lrMetrics
    
    # Classificacao para todos o conjunto de dados
    classAll_i = predict(model_lr_cv, train_df[c(1:4)])
    
    if(lrMetrics[1] < bestModelAcc){
      bestModelAcc = lrMetrics[1]
      classAll = ifelse(classAll_i < 0.5, 0, 1)
    }
  }
  
  if(exportResults == T){
    write.csv(resultMatrixCV, file = "Results/lr_cv_metrics.csv")
  }
  
  # Calculo do IC
  meanTaxaErroresult = mean(resultMatrixCV$TaxaErro)
  sdTaxaErroresult = sd(resultMatrixCV$TaxaErro)
  icTaxaErro = (t.test(resultMatrixCV$TaxaErro))$conf.int[1:2]
  
  meanPrecisao = mean(resultMatrixCV$Precisao)
  sdPrecisao = sd(resultMatrixCV$Precisao)
  icPrecisao = (t.test(resultMatrixCV$Precisao))$conf.int[1:2]
  
  meanCobertura = mean(resultMatrixCV$Cobertura)
  sdCobertura = sd(resultMatrixCV$Cobertura)
  icCobertura = (t.test(resultMatrixCV$Cobertura))$conf.int[1:2]
  
  meanFmeasureScore = mean(resultMatrixCV$Fmeasure)
  sdFmeasureScore = sd(resultMatrixCV$Fmeasure)
  icFmeasureScore = (t.test(resultMatrixCV$Fmeasure))$conf.int[1:2]
  
  icLR = as.data.frame(matrix(nrow = 4, ncol=3))
  names(icLR) = c('Mean', 'Inf', 'Sup')
  rownames(icLR) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure')
  icLR[1,1] = meanTaxaErroresult
  icLR[2,1] = meanPrecisao
  icLR[3,1] = meanCobertura
  icLR[4,1] = meanFmeasureScore
  icLR[1,2:3] = icTaxaErro
  icLR[2,2:3] = icPrecisao
  icLR[3,2:3] = icCobertura
  icLR[4,2:3] = icFmeasureScore
  
  if(exportResults == T){
    write.csv(icLR, file = "Results/lr_ic.csv")
  }
  
  result_df = as.data.frame(matrix(nrow = length(train_df[[1]]), ncol=2))
  names(result_df) = c('Target', 'LR')
  result_df$Target = train_df$class
  result_df$LR = classAll
  
  return(list('Metrics' = resultMatrixCV,
              'IC' = icLR,
              'Results'= result_df)
  )
}

# M2_cv - Classificador bayesiano (CB) com CV
getCBG_cv = function(train_df, exportResults = F){

  set.seed(2311)
  foldIndex = cvFolds(length(train_df$vwti), K = 10, R = 1)
  resultMatrixCV = as.data.frame(matrix(ncol=4, nrow=10))
  names(resultMatrixCV) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure')
  
  classAll = 1; bestModelAcc = 100
  for(i in 1:10){
    train = train_df[foldIndex$subsets[foldIndex$which != i], ] #Set the training set
    validation = train_df[foldIndex$subsets[foldIndex$which == i], ] #Set the validation set
    model_cbg_cv = naiveBayes(x = train[-5], 
                              y = train$class)
    
    cgb_predict = predict(model_cbg_cv, validation[c(1:4)])
    cbgMetrics_cv = getMetrics(cgb_predict, validation$class)
    resultMatrixCV[i,] = cbgMetrics_cv
    
    # Classificacao para todos o conjunto de dados
    cgb_predict_all = predict(model_cbg_cv, train_df[c(1:4)])
    cbgMetrics_all = getMetrics(cgb_predict_all, train_df$class)

    if(cbgMetrics_cv[1] < bestModelAcc){
      bestModelAcc = cbgMetrics_cv[1]
      classAll = cgb_predict_all
    }
  }
  
  if(exportResults == T){
    write.csv(resultMatrixCV, file = "Results/cbg_cv_metrics.csv")
  }

  # Calculo do IC
  meanTaxaErroresult = mean(resultMatrixCV$TaxaErro)
  sdTaxaErroresult = sd(resultMatrixCV$TaxaErro)
  icTaxaErro = (t.test(resultMatrixCV$TaxaErro))$conf.int[1:2]
  
  meanPrecisao = mean(resultMatrixCV$Precisao)
  sdPrecisao = sd(resultMatrixCV$Precisao)
  icPrecisao = (t.test(resultMatrixCV$Precisao))$conf.int[1:2]
  
  meanCobertura = mean(resultMatrixCV$Cobertura)
  sdCobertura = sd(resultMatrixCV$Cobertura)
  icCobertura = (t.test(resultMatrixCV$Cobertura))$conf.int[1:2]
  
  meanFmeasureScore = mean(resultMatrixCV$Fmeasure)
  sdFmeasureScore = sd(resultMatrixCV$Fmeasure)
  icFmeasureScore = (t.test(resultMatrixCV$Fmeasure))$conf.int[1:2]
  
  icCBG = as.data.frame(matrix(nrow = 4, ncol=3))
  names(icCBG) = c('Mean', 'Inf', 'Sup')
  rownames(icCBG) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure')
  icCBG[1,1] = meanTaxaErroresult
  icCBG[2,1] = meanPrecisao
  icCBG[3,1] = meanCobertura
  icCBG[4,1] = meanFmeasureScore
  icCBG[1,2:3] = icTaxaErro
  icCBG[2,2:3] = icPrecisao
  icCBG[3,2:3] = icCobertura
  icCBG[4,2:3] = icFmeasureScore
  
  if(exportResults == T){
    write.csv(icCBG, file = "Results/cbg_ic.csv")
  }
  
  result_df = as.data.frame(matrix(nrow = length(train_df[[1]]), ncol=2))
  names(result_df) = c('Target', 'CBG')
  result_df$Target = train_df$class
  result_df$CBG = classAll
  
  return(list('Metrics'= resultMatrixCV,
              'IC'= icCBG,
              'Results'= result_df
  )
  )
}

# M3_cv - Classificador bayesiano - KNN com CV
getKNN_cv = function(train_df, valid_df, exportResults = F){
  #train_df = dataNorm; valid_df = dataNormValid
  
  maxFmeasure = 0; maxk = NULL
  for(k in 1:30){ #k=1
    set.seed(1)
    previsoes = knn(train = dataValid[-5], 
                    test = dataValid[-5],
                    cl = dataValid$class,
                    k = k)
    
    metricFI = getMetrics(previsoes, dataValid$class)[4] 
    
    if(metricFI > maxFmeasure){
      maxFmeasure = metricFI
      maxk = k
    }
  }
  
  set.seed(2311)
  foldIndex = cvFolds(length(train_df$vwti), K = 10, R = 1)
  resultMatrixCV = as.data.frame(matrix(ncol=4, nrow=10))
  names(resultMatrixCV) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure')
  
  bestModelIndex = 1; bestModelAcc = 100; bestModel = NULL
  for(i in 1:10){
    train = train_df[foldIndex$subsets[foldIndex$which != i], ] #Set the training set
    test = train_df[foldIndex$subsets[foldIndex$which == i], ] #Set the validation set

    knn_Predict = knn(train = train[-5], 
                    test = test[-5],
                    cl = train$class,
                    k = maxk)
    
    resultMatrixCV[i,] = getMetrics(knn_Predict, test$class)

    knnMetrics = getMetrics(knn_Predict, test$class)
    resultMatrixCV[i,] = knnMetrics
  }
  
  if(exportResults == T){
    write.csv(resultMatrixCV, file = "Results/knn_cv_metrics.csv")
  }
  
  classAll = knn(train = train_df[-5], 
                    test = train_df[-5],
                    cl = train_df$class,
                    k = maxk)

  # Calculo do IC
  meanTaxaErroresult = mean(resultMatrixCV$TaxaErro)
  sdTaxaErroresult = sd(resultMatrixCV$TaxaErro)
  icTaxaErro = (t.test(resultMatrixCV$TaxaErro))$conf.int[1:2]
  
  meanPrecisao = mean(resultMatrixCV$Precisao)
  sdPrecisao = sd(resultMatrixCV$Precisao)
  icPrecisao = (t.test(resultMatrixCV$Precisao))$conf.int[1:2]
  
  meanCobertura = mean(resultMatrixCV$Cobertura)
  sdCobertura = sd(resultMatrixCV$Cobertura)
  #icCobertura = (t.test(resultMatrixCV$Cobertura))$conf.int[1:2]
  
  meanFmeasureScore = mean(resultMatrixCV$Fmeasure)
  sdFmeasureScore = sd(resultMatrixCV$Fmeasure)
  icFmeasureScore = (t.test(resultMatrixCV$Fmeasure))$conf.int[1:2]
  
  icKnn = as.data.frame(matrix(nrow = 4, ncol=3))
  names(icKnn) = c('Mean', 'Inf', 'Sup')
  rownames(icKnn) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure')
  icKnn[1,1] = meanTaxaErroresult
  icKnn[2,1] = meanPrecisao
  icKnn[3,1] = meanCobertura
  icKnn[4,1] = meanFmeasureScore
  icKnn[1,2:3] = icTaxaErro
  icKnn[2,2:3] = icPrecisao
  #icKnn[3,2:3] = icCobertura
  icKnn[4,2:3] = icFmeasureScore
  
  if(exportResults == T){
    write.csv(icKnn, file = "Results/knn_ic.csv")
  }
  
  result_df = as.data.frame(matrix(nrow = length(train_df[[1]]), ncol=2))
  names(result_df) = c('Target', 'KNN')
  result_df$Target = train_df$class
  result_df$KNN = classAll
  
  return(list('Metrics'= resultMatrixCV,
              'IC'= icKnn,
              'Results'= result_df
         )
  )
  
}


# Funcao - Normalize [0.2; 0.8]
normalize_2 = function(array, x = 0, y = 1){
  #Normalize to [0, 1]
  m = min(array)
  range = max(array) - m
  norm1 = (array - m) / range
  
  #Then scale to [x,y]
  range2 = y - x
  normalized = (norm1*range2) + x
  return(normalized)
}

# Calcula as metricas
getMetrics = function(y_pred, y_true){

  acc = Accuracy(y_pred, y_true)
  TaxaErro = 1 - acc
  recall = Recall(y_pred, y_true)
  f1Score = F1_Score(y_pred, y_true)
  precision = Precision(y_pred, y_true)
  
  metrics_df = as.data.frame(matrix(ncol=4, nrow=1))           
  names(metrics_df) = c('TaxaErro', 'Precisao', 'Cobertura', 'Fmeasure') 
  metrics_df$TaxaErro = TaxaErro
  metrics_df$Precisao = precision
  metrics_df$Cobertura = recall
  metrics_df$Fmeasure = f1Score
  
  return(metrics_df)
}
