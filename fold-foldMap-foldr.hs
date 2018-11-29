-- Implement fold in terms of foldMap.
-- What would you need in order to implement foldMap in terms of fold?
-- Implement foldMap in terms of foldr.
-- Implement foldr in terms of foldMap (hint: use the Endo monoid).
-- What is the type of foldMap . foldMap? Or foldMap . foldMap . foldMap, etc.? What do they do?

data List' a = None | Cons a (List' a) deriving Show

appendLists :: List' a -> List' a -> List' a
appendLists None ly = ly
appendLists (Cons x lx) ly = Cons x (appendLists lx ly)

instance Semigroup (List' a) where
    (<>) x y = appendLists x y

instance Monoid (List' a) where
    mempty = None
    mappend lx ly = appendLists lx ly

instance  Foldable List' where
    foldMap _ None = mempty
    foldMap g (Cons x lx) = (g x) `mappend` (foldMap g lx)
    -- foldr g y lx = (foldMap g lx) `mappend` : -- need to use Endo and appEndo, try and understand it later