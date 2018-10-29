takewhile::(a->Bool)->[a]->[a]
takewhile _ [] = []
takewhile f (x:xs) | f x == True = x : takewhile f xs 
                   | otherwise = [] 
