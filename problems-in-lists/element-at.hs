
elementAt :: [a] -> Int -> Maybe a
elementAt [] _ = Nothing
elementAt (x:xs) n = if n == 1 then (Just x) else elementAt xs (n-1)


 
