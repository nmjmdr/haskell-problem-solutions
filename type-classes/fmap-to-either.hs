class Functor' f where
    fmap' :: (a->b)->f a -> f b
    (<$) :: a ->f b -> f a
    (<$) = fmap' . const

instance Functor' (Either e) where
    fmap' _ (Left err) = Left err
    fmap' g (Right val) = Right $ g val

