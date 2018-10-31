
dropEveryIndex :: Int -> Int -> [a] -> [a] -> [a]
dropEveryIndex _ _ part [] = part
dropEveryIndex n index part (x:xs) = if index == n
                                     then dropEveryIndex n 1 part xs 
                                     else dropEveryIndex n (index+1) (part++[x]) xs

dropEveryNth :: Int -> [a] -> [a]
dropEveryNth _ [] = []
dropEveryNth n xs = dropEveryIndex n 1 [] xs

