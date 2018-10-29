toAbs::(Num x, Ord x) => x -> x
toAbs x  
 | x > 0 = x
 | otherwise = -x

