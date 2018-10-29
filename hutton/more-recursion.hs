andx::[Bool] -> Bool
andx [True] = True
andx (x:xs) | x == False = False
            | otherwise = x && (andx xs) 

concatx::[[a]] -> [a]
concatx [] = []
concatx (x:xs) = x ++ concatx xs

replicatex::Int->a->[a]
replicatex 0 _ = []
replicatex n a = [a] ++ replicatex (n-1) a

selectx::[a]->Int->Maybe a
selectx [] _ = Nothing
selectx (x:xs) n | n == 0 = Just x
                 | otherwise = selectx xs (n-1)

elemx::Eq a=>a->[a]->Bool
elemx _ [] = False
elemx a (x:xs) | a == x = True
               | otherwise = elemx a xs

