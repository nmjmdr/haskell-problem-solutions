
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

-- find min of lists by applying foldr
minimum' :: (Foldable' t, Ord a, Monoid' a) => t a -> a
minimum' xs = foldr' (\acc x -> if acc > x then x else acc) mempty' xs

data Min' a = Min' a deriving Show

instance Eq a => Eq (Min' a) where
    (==) (Min' x) (Min' y) = x == y

instance Ord a => Ord (Min' a) where
    (<=) (Min' x) (Min' y) = x <= y


instance (Num a, Bounded a, Ord a) => Monoid' (Min' a) where
    mempty' = Min' maxBound
    mappend' mx@(Min' x) my@(Min' y) = if x < y then mx else my



