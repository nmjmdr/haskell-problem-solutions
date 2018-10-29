insertin::Ord x=>x->[x]->[x]
insertin x [] = [x]
insertin x (y:ys) | x <=y = x : y : ys
                  | otherwise = y : insertin x ys


isort::Ord a=>[a]->[a]
isort [] = []
isort (x:xs) = insertin x (isort xs) 
