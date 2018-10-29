foldrx::(a->v->v)->v->[a]->v
foldrx f v [] = v
foldrx f v (x:xs) = f x (foldr f v xs)

productx::Num a=>[a]->a
productx = foldrx (*) 1

-- lengthx::[a]->Int
-- lengthx [] = 0
-- lengthx (x:xs) = 1 + length xs

lengthx::[a]->Int
lengthx = foldrx (\_ n -> n + 1) 0

-- reversi::[a]->[a]
-- reversi [] = []
-- reversi (x:xs) = (reversi xs) ++ [x]

snoci::a->[a]->[a]
snoci x xs = xs ++ [x]

reversi::[a]->[a]
reversi = foldrx snoci []

