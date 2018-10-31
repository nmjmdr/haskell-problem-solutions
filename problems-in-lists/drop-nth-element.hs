
dropIndex :: Int -> Int -> [a] -> [a] -> [a]
dropIndex _ _ part [] = part 
dropIndex n index part (x:xs) = if index == n 
                                 then part ++ xs 
                                 else dropIndex n (index+1) (part++[x]) xs
  

dropNth :: Int -> [a] -> [a]
dropNth _ [] = []
dropNth n xs = dropIndex n 0 [] xs
