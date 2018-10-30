
encodelens :: Eq a => [a] -> [(Int,a)]
encodelens xs = foldr (\x acc -> case acc of
                                  [] -> [(1,x)]
                                  (l:ls) -> if snd l == x then [(fst l + 1, x)] ++ ls else [(1,x)] ++ (l:ls)) [] xs

-- recursive version:

encodelens' :: Eq a => [a] -> [(Int,a)]
encodelens' [] = []
encodelens' xs = countLens xs []

countLens :: Eq a => [a] -> [(Int,a)] ->[(Int,a)]
countLens [] ls = ls
countLens (x:xs) [] = countLens xs [(1,x)]
countLens (x:xs) (l:ls) = countLens xs (if snd l == x then [(fst l + 1, x)] ++ ls else [(1,x)] ++ (l:ls))


 
                                            


