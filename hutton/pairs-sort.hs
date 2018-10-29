pairs::[a] -> [(a,a)]
pairs l = zip l (tail l)

sorted::Ord a => [a] -> Bool
sorted l = and [ x <= y | (x,y) <- (pairs l)]

