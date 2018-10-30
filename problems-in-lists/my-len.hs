myLen :: [a] -> Int
myLen [] = 0
myLen (x:xs) = 1 + myLen xs

myLen' :: [a] -> Int
myLen' xs = foldl (\l _ -> l + 1) 0 xs

