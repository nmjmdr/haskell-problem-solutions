safeTail1::[x]->[x]
safeTail1 xs = if length(xs) == 0 then [] else tail xs

safeTail2::[x]->[x]
safeTail2 xs
 | length(xs) == 0 = []
 | otherwise = tail xs

safeTail3::[x]->[x]
safeTail3 [] = []
safeTail3 xs = tail xs 
