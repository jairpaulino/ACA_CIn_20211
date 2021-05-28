getAStarPath = function(origin, destiny, distConnection = distConnection_df, distReal = distReal_df){
  
  #origin = 1; destiny = 12; 
  #distConnection = distConnection_df; distReal = distReal_df
  
  currentPoint = origin
  route = origin
  move = 1
  
  visited = rep(FALSE, 14)
  visited[currentPoint] = TRUE
  
  j = 0
  repeat{
    
    # Finding adjacent stations
    adjacent = which(is.na(distConnection[currentPoint, ]) %in% FALSE)
    
    # Calculating cost function
    cost = 0
    for (i in 1:length(adjacent)){#i=4
      if(visited[adjacent[i]] == FALSE){
        cost[i] = distConnection[currentPoint, adjacent[i]] + distReal[destiny, adjacent[i]]
      }else{
        cost[i] = NA
      }
    }
    
    costMatrix = na.omit(data.frame(adjacent, cost))
    
    print(paste('-----------', move, '-----------'))
    print(costMatrix)

    posCostMin = which(cost %in% min(na.omit(cost)))
    visited[adjacent[posCostMin]] = TRUE
    currentPoint = adjacent[posCostMin]
    route = c(route, currentPoint)
    move = move + 1
    
    if(currentPoint == destiny){
      break
    }
    
  }
  print("The final route is: ")
  print(route)
  
}


