
compress :: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:y:xs) = if x == y then compress (x:xs) else [x] ++ compress (y:xs)

compress' :: Eq a => [a] -> [a]
compress' xs = foldr ( \x acc -> case acc of 
                                   [] -> [x] 
                                   (a:ac) -> if a == x then (a:ac) else (x:a:ac)) [] xs





