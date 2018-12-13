class Functor' f where
    fmap' :: (a->b)->f a -> f b
    (<$) :: a ->f b -> f a
    (<$) = fmap' . const

instance Functor' ((,) e) where
    fmap' g (e,x) = (e, (g x))

data Pair a = Pair a a

instance Functor' Pair where
    fmap' g (Pair x y) = Pair (g x) (g y)
