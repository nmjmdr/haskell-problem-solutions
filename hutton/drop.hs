ddrop::Int->[a]->[a]
ddrop n [] = []
ddrop n (x:xs) | n == 0 = (x:xs)
               | otherwise = ddrop (n-1) xs
 
