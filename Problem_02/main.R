#Title: Q-Learning - ATIVIDIDADE 22/JUL/21 - ACA CIn/UFPE
#Author: Jair Paulino de Sales (BASEADO NA SOLUÇAO DE JULIANA LOUREIRO)

# Limpa o ambiente R
rm(list=ls()); graphics.off() 

# Chama as funções auxiliares implementadas
source("Auxiliar.R")

# Configura os parâmetros iniciais
alpha = 0.5; gamma = 0.8

# Inicializa a matriz Q 
q_mt = data.frame(matrix(0,6,4)); q_mt[6,] = 10
names(q_mt) = c('UP', 'DOWN', 'LEFT', 'RIGHT')

R = c(-1, 10, -10)
names(R) <- c("Outro", "6", "Parede")

# Matriz de ação-estado
matrizResultado_df = data.frame(UP = c("2", "3", "Parede", "5", "6", "Parede"),
                                DOWN = c("Parede", "1", "2", "Parede", "4", "5"), 
                                LEFT = c("Parede", "Parede", "Parede", "1", "2", "3"),
                                RIGHT = c("4", "5", "6", "Parede", "Parede", "Parede"))
matrizResultado_df

print("Matriz Q"); print(q_mt)

# Estado inicial - 1 UUUR
seq_init = c("UP", "UP", "UP", "RIGHT"); state = 1

print("Resultado (Estado Inicial 1) :")
# Executa função q_learning para a sequencia de ações informada
q_matrix_T1 = q_learning(state, seq_init, 
                        matrizResultado_df, 
                        R, q_mt, alpha, gamma)

# Estado inicial - 5 LLUR
seq_init_2 = c("LEFT", "LEFT", "UP", "RIGHT"); state = 5


# Executa função q_learning para a sequencia de ações informada
# Neste cenário já parte da matrix q resultante do aprendizado anterior

print("Resultado (Estado Inicial 5) :")
q_matrix_2 = q_learning(state, seq_init_2,
                        matrizResultado_df, 
                        R, q_matrix_T1, alpha, gamma)


