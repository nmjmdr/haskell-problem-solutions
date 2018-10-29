data Tree a = Leaf a | Node (Tree a) a (Tree a) | None deriving Show

flatten::(Tree a)->[a]
flatten (Leaf x) = [x]
flatten (Node l x r) = flatten l ++ [x] ++ flatten r


binSearch::Ord a=>a->(Tree a)->Bool
binSearch x (Leaf val) = x == val
binSearch x (Node l val r) | x == val = True
                           | x < val = binSearch x l
                           | otherwise = binSearch x r
  

binSearch'::Ord a=>a->(Tree a)->Bool
binSearch' x (Leaf val) = x == val
binSearch' x (Node l val r) | result == EQ = True
                            | result == LT = binSearch' x l
                            | otherwise = binSearch' x r
                            where result = compare x val

numNodes::(Tree a)->Int
numNodes (Leaf a) = 1
numNodes (Node l _ r) = 1 + (numNodes l) + (numNodes r)

balanced::(Tree a)->Bool
balanced (Leaf _) = True
balanced (Node l _ r) = (abs ((numNodes l) - (numNodes r)) <= 1) && (balanced l) && (balanced r)


level::(Tree a)->Int
level (Leaf _) = 1
level (Node l _ r) = 1 + lvl
                     where lvl = (if lv < rv then rv else lv)
                                 where 
                                  lv = level(l)
                                  rv = level(r) 

leafs::(Tree a)->Int
leafs (Leaf _) = 1
leafs (Node l _ r) = (leafs l) + (leafs r)

balance::[a]->(Tree a)
balance [] = None
balance [a] = (Leaf a)
balance xs = Node (balance left) val (balance right)
             where
              mid = (length xs `div` 2)
              left = (take mid xs)
              val = (xs!!mid)
              right = (drop (mid+1) xs)
 
 
