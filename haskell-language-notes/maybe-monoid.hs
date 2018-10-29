data Maybe' a = Nothing' | Just' a

instance Monoid (Maybe' a) where
 mempty = Nothing'
 mappend (Just' x) (Just' y) = Maybe' (x,y)
 mappend _ _ = Nothing'
 mconcat [] = mempty
 mconcat [x] = mempty
 mconcat (x:y:xs) = [(mappend x y)] ++ mconcat xs
  

