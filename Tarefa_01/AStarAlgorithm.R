getDistPath = function(route_a){
  
  if(is.null(route_a)){
    dist = 0
    return(dist)
  }
  
  numPoints = length(route_a[[1]]) - 1
  path = route_a[[1]][1:numPoints]
  
  for(i in 1:(numPoints-1)){#i=1
    dist = distConnection[path[i], path[i+1]]
  }
  
  return(dist)
}

getPath = function(route, distConnection = distConnection_df){
  numPoints = length(route) - 1
  dist = 0
  for(i in 1:(numPoints)){#i=1
    dist = dist + distConnection[route[i], route[i+1]]
  }
  return(dist)
}


getAStarPath = function(origin, destiny, 
                        distConnection = distConnection_df, 
                        distReal = distReal_df, detailedPath = F){
  
  #origin = 6; destiny = 7; 
  #distConnection = distConnection_df; distReal = distReal_df
 
  begin = proc.time()
  
  route_a = NULL; c = 1
  routeGuide = NULL
  move = 1
  
  if(origin == destiny){
    return("The Values 'Origin' and 'Destiny' must  to be different!")
  }
  
  currentPoint = origin
  route = origin
  move = c(origin)
  distance = 0
  routeGuide = list()
  
  visited = rep(FALSE, 14)
  visited[currentPoint] = TRUE
  
  repeat{
    
    adjacent = which(is.na(distConnection[currentPoint, ]) %in% FALSE)
    numberSons = length(adjacent)
    
    #f(n) = g(n) + h(n)
    cost = 0
    len = length(routeGuide)
    for(i in 1:length(adjacent)){#i=1
      cost[i] = getPath(c(route, adjacent[i])) + distReal[destiny, adjacent[i]] 
      routeGuide[[i+len]] = c(round(route, 0), round(adjacent[i], 0), round(cost[i], 1))
      visited[adjacent[i]] = TRUE
    }
    
    costMatrix = data.frame(adjacent, cost)
    
    min = 10e9
    for(m in 1:length(routeGuide)){#m=4
      correntValeu = routeGuide[[m]][length(routeGuide[[m]])]
      if(correntValeu < min){
        min = correntValeu
        posMin = m
      }
    }
    
    if(detailedPath == T){
      print(paste('-----------', move, '-----------'))
      print(routeGuide)
    }
    
    currentPoint = routeGuide[[posMin]][length(routeGuide[[posMin]])-1]
    route = routeGuide[[posMin]][-length(routeGuide[[posMin]])]
    routeGuide[[posMin]] = NULL
    route_a[[c]] = c(route, getPath(cost))

    # Index update
    c = c + 1
    move = move + 1
    
    if(currentPoint == destiny){
      break
    }
  }
  
  distance = getPath(route)
  
  print("The final route is: ")
  print(route)
  print(paste("The total time spent was: ", round(distance/30, 1), " hour(s)", sep=""))
  
  end = proc.time() - begin
  
  return(list("Route" = route,
              "TimeSpent" = round(distance/30, 1),
              "ProcTime" = as.numeric(end[3]))
         )
}



