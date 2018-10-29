-- Prelude> [(x,y) | x <- [1,2], y <- [3,4]]
-- [(1,3),(1,4),(2,3),(2,4)]

-- Prelude> [ [(x,y) | y <- [3,4]] | x <- [1,2] ]
-- [[(1,3),(1,4)],[(2,3),(2,4)]]

-- Prelude> concat [ [(x,y) | y <- [3,4]] | x <- [1,2] ]
-- [(1,3),(1,4),(2,3),(2,4)]

nestedCross::[a]->[b]->[(a,b)]
nestedCross xs ys = concat [ [(x,y) | y <- ys] | x <- xs]


