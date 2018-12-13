data Tree a = Node a (Tree a) (Tree a) | Leaf a | Empty deriving Show

data List' a = None | Cons a (List' a) deriving Show


appendLists :: List' a -> List' a -> List' a
appendLists None ly = ly
appendLists (Cons x lx) ly = Cons x (appendLists lx ly)

class Functor' f where
    fmap' :: (a -> b) -> f a -> f b

class Semigroup' a where
    combine' :: a -> a -> a

class Semigroup' a => Monoid' a where
    mempty'  :: a
    mappend' :: a -> a -> a

class Foldable' t where
    foldMap' :: Monoid' m => (a -> m) -> t a -> m
    foldr'   :: Monoid' b => (a -> b -> b) -> b -> t a -> b

class Functor' f => Applicative' f where
    pure'  :: a -> f a
    app' :: f (a->b) -> f a -> f b

class (Functor' t, Foldable' t) => Traversable' t where
    traverse'  :: Applicative' f => (a -> f b) -> t a -> f (t b)

instance Functor' Tree where
    fmap' _ Empty = Empty
    fmap' g (Leaf x) = Leaf (g x)
    fmap' g (Node x lt rt) = Node (g x) (fmap' g lt) (fmap' g rt)



instance Foldable' Tree where
    foldr' _ y Empty = y
    foldr' g y (Leaf x) = g x y
    foldr' g y (Node x lt rt) =  g x ((foldr' g mempty' lt) `mappend' `(foldr' g y rt))
    --foldMap' g xs = 

instance Traversable' Tree where
    traverse' _ Empty = 
    traverse' g t = app' (pure' g) t
    

-- Try to work it out: 

-- foldr' (+) 0 (Node 1 (Leaf 2) (Leaf 3))

-- <interactive>:4:1: error:
--     • No instance for (Monoid' a0) arising from a use of ‘it’
--     • In a stmt of an interactive GHCi command: print it

-- thus need to define a monoid

data Sum' a = Sum' a deriving Show

instance Num a => Semigroup' (Sum' a) where
    combine' (Sum' x) (Sum' y) = Sum' (x + y)

instance Num a => Monoid' (Sum' a) where
    mempty' = Sum' 0
    mappend' = combine'


-- foldr' (combine') (Sum' 0) (Node (Sum' 2) (Leaf (Sum' 1)) (Leaf (Sum' 1)))
-- Sum' 4