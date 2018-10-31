
splitAtIndex :: Int -> Int -> [a] -> [a] -> ([a],[a])
splitAtIndex _ _ part [] = (part,[])
splitAtIndex n index part (x:xs) = if n == index 
                                    then (part, (x:xs))
                                    else splitAtIndex n (index+1) (part++[x]) xs


splitat :: Int -> [a] -> ([a],[a])
splitat _ [] = ([],[])
splitat n xs = splitAtIndex n 0 [] xs
