all'::(a->Bool)->[a]->Bool
all' _ [] = True
all' f (x:xs) = (f x) && (all' f xs)

any'::(a->Bool)->[a]->Bool
any' _ [] = False
any' f (x:xs) = (f x) || (any' f xs)

takeWhile'::(a->Bool)->[a]->[a]
takeWhile' _ [] = []
takeWhile' f (x:xs) | (f x) == True = x : takeWhile' f xs
                    | otherwise = []

dropWhile'::(a->Bool)->[a]->[a]
dropWhile' _ [] = []
dropWhile' f (x:xs) | (f x) == True = dropWhile f xs
                    | otherwise = (x:xs) 
