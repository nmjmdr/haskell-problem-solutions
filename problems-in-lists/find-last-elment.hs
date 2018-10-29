
last' :: [a] -> Maybe a
last' [] = Nothing
last' [x] = Just x
last' (_:xs) = last' xs

last'' :: [a] -> Maybe a
last'' [] = Nothing
last'' xs = Just (xs !! (length xs -1))

last''' :: [a] -> Maybe a
last''' [] = Nothing
last''' xs = Just (head (reverse xs))


last'''' :: [a] -> Maybe a 
last'''' [] = Nothing
last'''' xs = Just (foldl (flip const) (head xs) xs)
 



