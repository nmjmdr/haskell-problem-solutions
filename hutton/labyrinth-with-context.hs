data Node a = Deadend a | Passage a (Node a) | Fork a (Node a) (Node a) deriving Show

 -- t = Fork 1 (Fork 2 (Deadend 3) (Deadend 4)) (Passage 5 (Fork 6 (Passage 7 (Deadend 8)) (Deadend 9)))

get::Node a -> a
get (Deadend x) = x
get (Passage x _) = x
get (Fork x _ _) = x

put::a->Node a->Node a
put a (Deadend _) = Deadend a
put a (Passage _ n) = Passage a n
put a (Fork _ l r) = Fork a l r

data Branch = KeepStraightOn | TurnLeft | TurnRight deriving Eq
type Thread = [Branch]

retrieve :: Thread -> Node a -> a
retrieve [] n = get n
retrieve (KeepStraightOn:bs) (Passage _ n) = retrieve bs n
retrieve (TurnLeft:bs) (Fork _ l _) = retrieve bs l
retrieve (TurnRight:bs) (Fork _ _ r) = retrieve bs r

putf::(a->a)->Node a->Node a
putf f (Deadend a) = Deadend (f a)
putf f (Passage a n) = Passage (f a) n
putf f (Fork a l r) = Fork (f a) l r


-- returns the subtree with the root as the player's position
update :: Thread -> (a->a) -> Node a -> Node a
update [] f n = putf f n
update (KeepStraightOn:bs) f (Passage _ n) = update bs f n
update (TurnLeft:bs) f (Fork _ l r) = update bs f l
update (TurnRight:bs) f (Fork _ l r) = update bs f r

-- applies a function to data in all nodes of the tree
applyAll::(a->a)->Node a->Node a
applyAll f (Deadend a) = Deadend (f a) 
applyAll f (Passage a n) = Passage (f a) (applyAll f n)
applyAll f (Fork a l r) = Fork (f a) (applyAll f l) (applyAll f r)

-- applies a function to the position pointed to by Thread, ends up storing current position in the second parameter
-- ends up naviagting the whole of tree to update the position
applyAt::(a->a)->Thread->Thread->Node a->Node a
applyAt f source target (Deadend a) = 
 if source == target then 
  Deadend (f a) 
 else 
  Deadend a
applyAt f source target (Passage a n) = 
 if source == target then 
  Passage (f a) (applyAt f source [] n) 
 else 
  Passage a (applyAt f source (target ++ [KeepStraightOn]) n)
applyAt f source target (Fork a l r) = 
 if source == target then 
  Fork (f a) (applyAt f source [] l) (applyAt f source [] r) 
else 
 Fork a (applyAt f source (target ++ [TurnLeft]) l) (applyAt f source (target ++ [TurnRight])  r)

data Record a = KeptStraight (Node a) | TurnedLeft (Node a) | TurnedRight (Node a)
type Context a = [Record a]

-- Takes a child to insert and record containing the parent, updates the parent with the child and returns the parent
putChild :: Node a -> Record a -> Node a
putChild n (KeptStraight (Passage x _))  = Passage x n
putChild n (TurnedLeft (Fork x _ r)) = Fork x n r
putChild n (TurnedRight (Fork x l _)) = Fork x l n

updateFast :: a -> Thread -> Context a -> Node a -> Node a
updateFast a [] (rec:ctx) n = putChild child rec where child = put a n
updateFast a (KeepStraightOn:th) ctx (Passage x n) =  (Passage x updated) where updated = updateFast a th ((KeptStraight (Passage x n)):ctx) n
updateFast a (TurnLeft:th) ctx (Fork x l r) = (Fork x updated r) where updated = updateFast a th ((TurnedLeft (Fork x l r)):ctx) l
updateFast a (TurnRight:th) ctx (Fork x l r) = (Fork x l updated) where updated = updateFast a th ((TurnedRight (Fork x l r)):ctx) r

