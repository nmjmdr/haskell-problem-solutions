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
    -- foldr' g y lx = foldMap' g lx to see how to implement foldr' using foldMap' 
    -- see: https://stackoverflow.com/questions/16757373/where-do-the-foldl-foldr-implementations-of-foldable-come-from-for-binary-trees?rq=1

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