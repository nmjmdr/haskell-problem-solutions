class Monoid' a where
    mempty' :: a
    mappend' :: a -> a -> a
    
data List' a = None | Cons a (List' a) deriving Show

appendLists :: List' a -> List' a -> List' a
appendLists None ly = ly
appendLists (Cons x lx) ly = Cons x (appendLists lx ly)

instance Monoid' (List' a) where
    mempty' = None
    mappend' lx ly = appendLists lx ly
    

class Foldable' t where
    foldMap' :: Monoid' m => (a -> m) -> t a -> m
    foldr' :: (a -> b -> b) -> b -> t a -> b

instance Foldable' List' where
    foldMap' _ None = mempty'
    foldMap' g (Cons x lx) = (g x) `mappend'` (foldMap' g lx)
    foldr' _ y None = y
    foldr' g y (Cons x lx) = g x (foldr' g y lx)
    
    -- now implementing Foldable and Monoid
instance Semigroup (List' a) where
    (<>) x y = appendLists x y
    
instance Monoid (List' a) where
    mempty = None
    mappend lx ly = appendLists lx ly
    
instance Foldable List' where
    foldMap _ None = mempty
    foldMap g (Cons x lx) = (g x) `mappend` (foldMap g lx)
    
    -- foldr (\x acc -> acc + x) 0 (Cons 1 (Cons 2 (None)))
    -- 3
    
toList' :: (Foldable f) => f a -> [a]
toList' lx = foldMap (\x -> [x]) lx




minimum' :: (Foldable f, Monoid a, Ord a) => f a -> a
minimum' = foldr (\acc x -> if acc > x then x else acc) mempty 

-- The above definition will not work for [1,2,3] : Int, as it would not know what to use for mempty
-- but the following works:

-- l = [Data.Semigroup.Min 50,Data.Semigroup.Min 2]
-- *Main> (minimum' l) :: (Data.Semigroup.Min Int)
-- Min {getMin = 2}

-- a should be of type (Min a) and it should implement a Monoid

