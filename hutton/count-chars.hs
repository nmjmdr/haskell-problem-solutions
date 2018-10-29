countChars::Char->[Char]->Int
countChars x xs = length [x' | x' <- xs, x' == x ]

