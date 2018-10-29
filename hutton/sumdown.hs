sumdown::Int->Int
sumdown n | n <= 0 = 0  
          | otherwise = n + sumdown (n-1)
 

