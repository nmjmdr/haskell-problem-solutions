data Tree a = Bin (Tree a) (Tree a) | Leaf a deriving Show

data Branch a = TookLeft (Tree a) | TookRight (Tree a) deriving Show
type Thread a = [Branch a]

-- Thread stores the sub-tree that is getting lost
-- Zipper stores the thread and the current sub-tree

type Zipper a = (Thread a, Tree a)

left :: Zipper a -> Maybe (Zipper a)
left (_, Leaf _) = Nothing
left (t, (Bin l r)) = Just (TookLeft r:t, l)

right :: Zipper a -> Maybe (Zipper a)
right (_, Leaf _) = Nothing
right (t, (Bin l r)) = Just (TookRight l:t, r)

back :: Zipper a -> Maybe (Zipper a)
back ([],n) = Nothing
back ((TookLeft r):th, l) = Just (th, (Bin l r))
back ((TookRight l):th, r) = Just (th, (Bin l r)) 



