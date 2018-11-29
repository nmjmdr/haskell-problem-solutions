toList :: (Foldable f) => f a -> [a]
toList lx = foldMap (\x -> [x]) lx
