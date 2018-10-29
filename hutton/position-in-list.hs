pos::Eq a => a -> [a] -> [Int]
pos a l = [ y | (x,y) <- (zip l [0..]), x == a]
