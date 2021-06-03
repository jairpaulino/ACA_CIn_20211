#Title: A* pathfinding algorithm
#Author: Jair Paulino
#Date: 2021/mai/27

# Setup ----
# Cleaning R environment
rm(list=ls()); graphics.off() 

# Libraries

# Importing functions
source("AStarAlgorithm.R")
source("AStarAlgorithmModified.R")

# Importing data
distConnection_df = read.csv(file = "dist_conexao.csv", sep=";")
rownames(distConnection_df) = colnames(distConnection_df)
distReal_df = read.csv(file = "dist_real_direta.csv", sep=";")
rownames(distReal_df) = colnames(distReal_df)
#View(distConnection_df); View(distReal_df)


AStarPath = getAStarPath(origin = 6,
                         destiny = 14,
                         distReal = distReal_df, 
                         distConnection = distConnection_df, 
                         detailedPath = T)
AStarPath
