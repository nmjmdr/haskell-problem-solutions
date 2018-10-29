class Applicative' f where
 pack :: a -> f a
 unpack :: f a -> a

data Box x = Box x deriving Show
data Bag x = Bag x deriving Show


instance Applicative' Box where
 pack x = Box x
 unpack (Box x) = x

instance Applicative' Bag where
 pack x = Bag x
 unpack (Bag x) = x

-- can we do the following:
-- [Box1, Box2, Box3] ==> Box [ x1, x2, x3 ]
-- using pack unpack

combine :: Applicative' f => [f x] -> f [x]
combine [] = pack []
combine (b:bxs) = pack ( (unpack b) : unpack (combine bxs) )
 
-- we could easily do the following:
-- [fn] [Box 1, Box 2, Box 3] ==> Box [ fn1(1), fn2(2), fn3(3) ]
 
-- How do we do this?, can we do the following?
--  [Box 1,Box 2, Box 3] = Box [6], using foldl

foldl' :: Applicative' f => (b->a->b) -> (f b) -> [f a] -> f b
foldl' g acc [bx] = pack (g (unpack acc) (unpack bx))
foldl' g acc (bx:bxs) =  foldl' g (pack (g (unpack acc) (unpack bx))) bxs

-- foldl' (+) (Box 0) [(Box 1),(Box 2),(Box 3)]
-- Box 6

-- can the above function be simpled to --->  foldl'::Applicative' f => (b->a->b) -> b -> [f a] -> f b ?
foldl'' :: Applicative' f => (b->a->b) -> b -> [f a] -> f b
foldl'' g acc [bx] = pack (g acc (unpack bx))
foldl'' g acc (bx:bxs) =  foldl'' g (g acc (unpack bx)) bxs

-- *Main> foldl'' (+) 0 [(Box 1),(Box 2),(Box 3)]
-- Box 6

