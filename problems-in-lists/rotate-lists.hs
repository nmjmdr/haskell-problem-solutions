
rotate' :: [a] -> Int -> [a]
rotate' [] _ = []
rotate' l@(x:xs) n | n == 0 = l
                   | n > 0 = rotate' (xs++[x]) (n-1)
                   | otherwise = rotate' ([(l !! (length l -1))] ++ (take (length l -1) l)) (n+1)

-- works but look at the ungliness in the code for otherwise and does many iterations of the list

-- trick: If n < 0, convert the problem to the equivalent problem for n > 0 by adding the list's length to n.

rotate :: [a] -> Int -> [a]
rotate xs n | n > 0 = rotateMod xs n
            | otherwise = rotateMod xs (length xs + n)

rotateMod :: [a] -> Int -> [a]
rotateMod [] _ = []
rotateMod l@(x:xs) n | n == 0 = l
                     | otherwise = rotateMod (xs++[x]) (n-1)
  
