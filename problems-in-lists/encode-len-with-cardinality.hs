
data Repeats a = Single a | Multiple Int a deriving Show

encodelens :: Eq a => [a] -> [Repeats a]
encodelens xs = foldr (\x acc -> case acc of
                                  [] -> [Single x]
                                  (l:ls) -> case l of 
                                             (Single x') -> if x == x' 
                                                             then [(Multiple 2 x)] ++ ls 
                                                             else [(Single x)] ++ (l:ls)
                                             (Multiple c x') -> if x == x'
                                                                 then [(Multiple (c+1) x)] ++ ls
                                                                 else [(Single x)] ++ (l:ls)
                      ) [] xs

decodelens :: Eq a => [Repeats a] -> [a]
decodelens [] = []
decodelens (r:rs) = case r of
                     (Single x) -> [x] ++ decodelens rs
                     (Multiple c x) -> take c (repeat x) ++ decodelens rs

