map'::(a->a)->[a]->[a]
map' f = foldr (\x xs -> (f x) : xs) [] 

appendIfTrue::(a->Bool)->a->[a]->[a]
appendIfTrue f x xs | (f x) == True = (x:xs)
                    | otherwise = xs

filter'::(a->Bool)->[a]->[a]
filter' f = foldr (appendIfTrue f) []


