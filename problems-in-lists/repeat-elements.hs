
repeatElements :: Int -> [a] -> [a]
repeatElements _ [] = []
repeatElements n (x:xs) = take n (repeat x) ++ repeatElements n xs
 
