plotGraphBestRoute = function(){
  
  plot(x = c(-8, -5, -2, 1, 4 , 5 , 3.1 , 2, -2 , -6, -4, 2 , 0   , -0.5), 
       y = c(5 , 4 , 2 , 1, -2, -3, -2.8, 8, 7.5, 2 , 13, 12, -3.8, 6),
       pch = 19, 
       cex = 1.5, axes = F, xlab = "", ylab = "")
  text("E1", x = -8.1, y = 5.1)
  text("E2", x = -5.1, y = 4.1)
  text("E3", x = -2.1, y = 2.1)
  text("E4", x = 1.1, y = 1.1)
  text("E5", x =4.1, y = -2.1)
  text("E6", x =5.1, y = -3.1)
  text("E7", x =3.2, y = -2.9)
  text("E8", x = 2.1, y = 8.1)
  text("E9", x = -2.1, y = 7.6)
  text("E10", x = -6.1, y = 2.1)
  text("E11", x = -4.1, y = 13.1)
  text("E12", x = 2.1, y = 12.1)
  text("E13", x = 0.1, y = -3.6)
  text("E14", x = -0.6, y = -6.1)
  lines(x = c(-8, -5), y = c(5 , 4), lwd = 2, col = 2)
}


# g1 = graph(edges=c(1,2, 2,3, 3, 1), n=3, directed=F ) 
# plot(g1)
