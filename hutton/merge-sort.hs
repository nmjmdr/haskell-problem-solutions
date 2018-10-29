mergesorted::Ord a=>[a]->[a]->[a]
mergesorted [] xs = [] ++ xs
mergesorted xs [] = xs ++ []
mergesorted (x:xs) (y:ys) | x < y = [x] ++ mergesorted xs (y:ys)
                          | otherwise = [y] ++ mergesorted (x:xs) ys

splitat::Int->[a]->[[a]]
splitat n xs = [ (take n xs), (drop n xs)]

halve xs = splitat (floor (fromIntegral (length xs) / 2)) xs

msort::Ord a=>[a]->[a]
msort [] = []
msort [x] = [x]
msort xs = 
 mergesorted (msort fh) (msort sh)  where [fh, sh] = halve xs

 
