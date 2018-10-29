data Node a = Deadend a | Passage a (Node a) | Fork a (Node a) (Node a) deriving Show

-- Branch now stores the action taken, and the information that would be lost: the current node data, and the right or left node
data Branch a = KeepStraightOn a | TurnLeft a (Node a) | TurnRight a (Node a) deriving Show
type Thread a = [Branch a]

-- Zipper stores series of branches (containing info that is required to rebuild the tree) and the current sub-tree
type Zipper a = (Thread a, Node a)

-- Returns a Zipper with Thead with saved info and the sub-tree on right
turnRight :: Zipper a -> Maybe (Zipper a)
turnRight (t, Fork x l r) = Just ( (TurnRight x l):t, r)
turnRight _ = Nothing

-- Returns a Zipper with Thead with saved info and the sub-tree on straigh on
keepStraightOn :: Zipper a -> Maybe (Zipper a)
keepStraightOn (t, Passage x n) = Just ( (KeepStraightOn x) : t , n)
keepStraightOn _ = Nothing

-- Returns a Zipper with Thead with saved info and the sub-tree on left
turnLeft :: Zipper a -> Maybe (Zipper a)
turnLeft (t, Fork x l r) = Just ( (TurnLeft x r):t, l)

back :: Zipper a -> Maybe (Zipper a)
back ([], t) = Nothing
back (((KeepStraightOn a):t), n) = Just (t, Passage a n)
back (((TurnRight a l):t), r) = Just(t, Fork a l r)
back (((TurnLeft a r):t), l) = Just(t, Fork a l r)

get::Node a -> a
get (Passage x _) = x
get (Fork x _ _) = x
get (Deadend x) = x

put:: (a->a) -> Node a -> Node a
put f (Passage x n) = Passage (f x) n
put f (Fork x l r) = Fork (f x) l r
put f (Deadend x) = Deadend (f x) 

update::(a->a)->Zipper a->Zipper a
update f (th,n) = (th,put f n)

 

