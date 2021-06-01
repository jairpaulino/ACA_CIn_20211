getAStarPath = function(origin, destiny, 
                        distConnection = distConnection_df, 
                        distReal = distReal_df, detailedPath = F){
  
  #origin = 1; destiny = 12; 
  #distConnection = distConnection_df; distReal = distReal_df
  
  if(origin == destiny){
    return("The Values 'Origin' and 'Destiny' must  to be different!")
  }
  
  currentPoint = origin
  route = origin
  move = 1
  distance = 0
  
  visited = rep(FALSE, 14)
  visited[currentPoint] = TRUE
  
  repeat{
    
    # Finding adjacent stations
    adjacent = which(is.na(distConnection[currentPoint, ]) %in% FALSE)
    
    # Calculating cost function
    cost = 0
    for(i in 1:length(adjacent)){#i=1
      # Analysing if the point has already been visited
      if(visited[adjacent[i]] == FALSE){
        nextAdjacent = which(is.na(distConnection[adjacent[i], ]) %in% FALSE)
        # Analysing if there is an exit route or if it is the last point
        if(length(nextAdjacent) > 1 | adjacent[i] == destiny){
          cost[i] = distConnection[currentPoint, adjacent[i]] + distReal[destiny, adjacent[i]]
        }else{
          cost[i] = NA # Delete the point if it is unfeasible
        }
      }else{
        cost[i] = NA # Delete the point if it has already been visited
      }
    }
    
    if(detailedPath == T){
      costMatrix = data.frame(adjacent, cost)
      print(paste('-----------', move, '-----------'))
      print(costMatrix)
      costMatrix = na.omit(data.frame(adjacent, cost))
    }else{
      costMatrix = na.omit(data.frame(adjacent, cost))
      print(paste('-----------', move, '-----------'))
      print(costMatrix)
    }

    # Updating information
    posCostMin = which(cost %in% min(na.omit(cost)))
    visited[adjacent[posCostMin]] = TRUE
    distance = distance + distConnection[currentPoint, adjacent[posCostMin]]
    currentPoint = adjacent[posCostMin]
    route = c(route, currentPoint)
    move = move + 1
    
    if(currentPoint == destiny){
      break
    }
  }
  
  print("The final route is: ")
  print(route)
  print(paste("The total time spent was: ", round(distance/30,2), " hour(s)", sep=""))
  return(list("Route" = route,
              timeSpent = round(distance/30,2)))
}


