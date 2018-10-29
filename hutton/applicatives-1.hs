class Functor' f where
 fmap0 :: a -> f a
 fmap1 :: (a->b) -> f a -> f b
 fmap2 :: (a->b->c) -> f a -> f b -> f c

data List' a = Empty | Cons a (List' a) deriving Show

instance Functor' List' where
 fmap0 a = Cons a (Empty)
 fmap1 _ Empty = Empty
 fmap1 g (Cons x l) = Cons (g x) (fmap1 g l)
 fmap2 _ Empty _ = Empty
 fmap2 _ _ Empty = Empty
 fmap2 g (Cons x lx) (Cons y ly) = Cons (g x y) (fmap2 g lx ly) 


gEx :: Num a => a -> Bool -> a
gEx i b = i + d where d = if b then 2 else 3

-- *Main> t = Cons 1 (Cons 2 (Cons 3 (Empty)))
-- *Main> b = Cons True (Cons False (Empty))
-- *Main> fmap2 gEx t b
-- Cons 3 (Cons 5 Empty)
-- *Main> b = Cons True (Cons False (Cons True (Empty)))
-- *Main> fmap2 gEx t b
-- Cons 3 (Cons 5 (Cons 5 Empty))

-- pure :: a -> f a
-- (<*>) :: f (a->b) -> f a -> f b

-- Ex of a->b => gEX
-- f (a->b) => t = Cons (gEx) (Cons (gEx) (Cons (gEx) (Empty) ))

class Applicative' f where
 purea :: a -> f a
 app :: f (a->b) -> f a -> f b

instance Applicative' List' where
 purea x = Cons x (Empty)
 app _ Empty = Empty
 app (Cons fn (Empty)) (Cons x l) = Cons (fn x) (app (purea fn) l)
 app (Cons fn fnl) (Cons x l) = Cons (fn x) (app fnl l) 


-- Example ==>
-- *Main> g = \x-> even x
-- *Main> l = Cons 2 (Cons 3 (Empty))
-- *Main> app (purea g) l
-- Cons True (Cons False Empty)
-- *Main>

fmap1' :: (Applicative' f)=>(a->b) -> f a -> f b
fmap1' g x = app (purea g) x
-- Example:
-- *MGain>
-- *Main> g = \x-> even x
-- *Main> l = Cons 2 (Cons 3 (Empty))
-- *Main> fmap1 (g) l
-- Cons True (Cons False Empty)
-- *Main> 

fmap2' :: (Applicative' f)=>(a->b->c) -> f a -> f b -> f c
fmap2' g x y = app (app (purea g) x) y
-- Example:
-- *Main> g = \x y -> even (x+y)
-- *Main> l = Cons 2 (Cons 3 (Empty))
-- *Main> r = Cons 2 (Cons 4 (Empty))
-- *Main> fmap2 g l r
-- Cons True (Cons False Empty)
-- *Main>

fmap3' :: (Applicative' f)=>(a->b->c->d) -> f a -> f b -> f c -> f d
fmap3' g x y z = app (app (app (purea g) x) y) z

-- Example
-- *Main> g = \x y z -> even (x+y+z)
-- *Main> l = Cons 2 (Cons 3 (Empty))
-- *Main> r = Cons 2 (Cons 4 (Empty))
-- *Main> s = Cons 3 (Cons 5 (Empty))
-- *Main> fmap3' g l r s
-- Cons False (Cons True Empty)

-- Another applicative example
data Maybe' a = Nothing' | Just' a deriving Show

-- purea :: a -> f a
-- app :: f (a->b) -> f a -> f b
instance Applicative' Maybe' where
 -- purea x = Just' x, -- can be just written as:
 purea = Just'
 app _ (Nothing') = Nothing'
 app (Just' g) (Just' x) = Just' (g x)
 
-- The following defintion acts like ZipList
--instance Applicative' [] where
-- purea x = [x]
-- app _ [] = []
-- app [g] (x:xs) = [(g x)] ++ app [g] xs
-- app (g:gs) (x:xs) = [(g x)] ++ app gs xs

-- Ex
-- Ok, one module loaded.
-- *Main> g = \x y -> x*y
-- *Main> arr1 = [1,2,3]
-- *Main> arr2 = [4,5,6]
-- *Main> fmap2' g arr1 arr2
-- [4,10,18]
-- *Main>
 
-- reference: https://stackoverflow.com/q/50701827/46279 for further discussion
-- next steps: write anti zip list for above

-- This definition acts like the anti-ziplist (extending the shorter list) as referenced above
instance Applicative' [] where
 purea x = [x]
 app [] _ = []
 app _ [] = []
 app [g] [x] = [(g x)]
 app (g:gs) [x] = [(g x)] ++ app gs [x]
 app [g] (x:xs) = [(g x)] ++ app [g] xs
 app (g:gs) (x:xs) = [(g x)] ++ app gs xs

-- Ok, one module loaded.
-- *Main> g = \x y -> x*y
-- *Main> arr1 = [1,2,3,5,6,7]
-- *Main> arr2 = [4,5,6]
-- *Main> fmap2' g arr1 arr2
-- [4,10,18,30,36,42]
-- *Main>
-- *Main> fmap2' g arr2 arr1
-- [4,10,18,30,36,42]
