# Atualiza o valor da utilidade
q_update = function(alpha, gamma,q_sa, q_next_sa, rw_acao) {  
  return(q_sa + alpha * (rw_acao + gamma * q_next_sa - q_sa))
}


# Algoritmo Q-learning
q_learning = function(estado, sequencia, matriz_r, 
                      R, q_mt, alpha, gamma){
  
  for(i in 1:length(sequencia)){
    
    next_estado = matriz_r[estado,sequencia[i]]
    
    cat("\n")
    cat(paste("Estado inicial: ", estado, "\n", sep = ""))
    cat(paste("Estado final: ", next_estado, "\n", sep = ""))
    cat(paste("Action: ", sequencia[i], "\n", sep = ""))

    if (next_estado == '6' | next_estado == 'Parede'){
      rw = next_estado
    }else{
      rw = "Outro"
    }
    
    rw_acao = R[rw]
    sprintf("Recompensa: %1.0f",rw_acao)
    
    estado_acao_q = q_mt[estado, sequencia[i]]
    
    if(next_estado != "Parede") {
      next_estado = as.integer(next_estado)
    }else{
      next_estado = estado
    }
    
    next_estado_utility = max(q_mt[next_estado,])
    
    q_mt[estado,sequencia[i]] = q_update(alpha,gamma,
                                      estado_acao_q, 
                                      next_estado_utility,
                                      rw_acao)
    
    cat("\nMatrix Q\n"); print(q_mt)
    estado = next_estado
  }
  return(as.matrix(q_mt))
} 
