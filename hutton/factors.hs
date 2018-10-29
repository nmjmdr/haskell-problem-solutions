factors::Int->[Int]
factors n = [x | x <-[1..n], n `mod` x == 0]

-- isPerfectSum k = sum [ x | x <- factors k, x /= k ] == k

perfects::Int->[Int]
-- perfects n = [ y | y <- [1..n], isPerfectSum y ]  
perfects n = [ y | y <- [1..n], (sum [ x | x <- factors y, x /= y ] == y) ]

 
