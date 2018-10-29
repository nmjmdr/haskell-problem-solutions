class Functor' f where
 fmap' :: (a->b) -> f a -> f b

data List' a = Empty | Cons a (List' a) deriving Show

instance Functor' List' where
 fmap' f Empty = Empty
 fmap' f (Cons x l) = Cons (f x) (fmap' f l) 

data Bin a = Leaf a | Bin (Bin a) (Bin a) deriving Show

instance Functor' Bin where
 fmap' f (Leaf a) = Leaf (f a)
 fmap' f (Bin l r) = Bin (fmap' f l) (fmap' f r)


instance Functor' Maybe where
 fmap' _ Nothing = Nothing
 fmap' g (Just x) = Just (g x)

-- [] is defined as ==>  data [] a = [] | a : [a] 	-- Defined in ‘GHC.Types’
instance Functor' [] where
 fmap' _ [] = []
 fmap' g (x:xs) = (g x):(fmap' g xs)


-- Good example:
-- *Main> t = Cons 1 (Cons 2 (Cons 3 (Empty)))
-- *Main> fmap' (even) t 
-- Cons False (Cons True (Cons False Empty))
-- *Main>


-- functor laws
-- fmap o id = id
-- fmap (g o h) = (fmap g) o (fmap h)

-- identity
-- *Main> g = fmap' (\x->x)
-- *Main> g (Cons 1 (Cons 2 (Empty)))
-- Cons 1 (Cons 2 Empty) <-- Result 1
-- *Main> g (Cons 1 (Cons 2 (Empty)))
-- Cons 1 (Cons 2 Empty) <-- Result 2
-- Result 1 = Result 2

-- Associative:
-- *Main> g = \x->x*10
-- *Main> h = \x->x*3
-- *Main> c1 = fmap' (g.h)
-- *Main> c1 (Cons 1 (Cons 2 (Empty)))
-- Cons 30 (Cons 60 Empty)
-- *Main> cg = fmap' g
-- *Main> ch = fmap' h
-- *Main>
-- *Main> c2 = cg . ch
-- *Main> c2 (Cons 1 (Cons 2 (Empty)))
-- Cons 30 (Cons 60 Empty)
-- *Main>


