
rev :: [a] -> [a]
rev [] = []
rev (x:xs) = rev xs ++ [x]

rev' :: [a] -> [a]
rev' xs = foldl (\s x -> [x] ++ s) [] xs

rev'' :: [a] -> [a]
rev'' xs = foldr (\x s -> s ++ [x]) [] xs



