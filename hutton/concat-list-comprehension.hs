conc::[[a]] -> [a]
conc xss = [ x | xs <- xss, x <- xs]

