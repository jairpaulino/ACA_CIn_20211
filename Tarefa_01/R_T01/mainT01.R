#Title: A star algorithm
#Author: Jair Paulino
#Date: 2021/mai/27

# Cleaning R environment
rm(list=ls()); graphics.off() 

# Libraries

# Importing functions
source("AStarAlgorithm.R")

# Importing data
distConnection_df = read.csv(file = "Tarefa_01/dist_conexao.csv", sep=";")
rownames(distConnection_df) = colnames(distConnection_df)
distReal_df = read.csv(file = "Tarefa_01/dist_real_direta.csv", sep=";")
rownames(distReal_df) = colnames(distReal_df)
#View(distConnection_df); View(distReal_df)

# Calculating patihing with A* algorithm
getAStarPath(origin = 1, 
             destiny = 12,
             distReal = distReal_df, 
             distConnection = distConnection_df)

polt()
