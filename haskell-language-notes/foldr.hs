foldr' :: (a->b->b) -> b -> [a] -> b
foldr' f b [] = b
foldr' f b (x:xs) = f x (foldr' f b xs)

