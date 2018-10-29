
lastbutone :: [a] -> a
lastbutone [] = error "empty list"
lastbutone [x] = x
lastbutone xs = xs !! (length xs -2)

lastbutone' :: [a] -> a
lastbutone' xs = pickx xs (length xs -2)

lastbutone'' = head .tail. reverse

pickx :: [a] -> Int -> a
pickx [] _ = error "empty list"
pickx (x:xs) n = if n == 0 then x else pickx xs (n-1)

-- from here: https://wiki.haskell.org/99_questions/Solutions/2
lastbut1safe :: Foldable f => f a -> Maybe a
lastbut1safe = fst . foldl (\(a,b) x -> (b,Just x)) (Nothing,Nothing)

-- amazing ^

