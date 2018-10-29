dec2int::[Int]->Int
dec2int = foldl (\x v -> x * 10 + v) 0

