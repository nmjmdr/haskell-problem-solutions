altMap::(a->b)->(a->b)->[a]->[b]
altMap _ _ [] = []
altMap f1 f2 xs = [ (f a)  | (a,f) <- zip xs (cycle [f1, f2]) ]

luhn::[Int]->Bool
luhn [] = True
luhn xs = (sum (altMap (\x->x) (\x-> if (x*2)>9 then (x*2)-9 else (x*2)  ) [ x | x <- reverse xs])) `mod` 10 == 0
