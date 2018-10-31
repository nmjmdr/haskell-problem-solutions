
removeAt :: [a] -> Int -> [a]
removeAt [] _ = []
removeAt (x:xs) n | n == 0 = xs
                  | otherwise = [x] ++ removeAt xs (n-1)

