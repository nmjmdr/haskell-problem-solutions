pali :: Eq a => [a] -> Bool
pali xs = xs == reverse xs

pali' :: Eq a => [a] -> Bool
pali' xs = palicompare xs 0 (length xs -1) where
                                              palicompare xs i j = i >= j || (xs !! i) == (xs !! j) && palicompare xs (i+1) (j-1)


 
