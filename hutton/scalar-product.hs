scalarproduct::[Int]->[Int]->Int
scalarproduct xs ys =  sum [ (fst p) * (snd p) | p <- zip xs ys]  
