class Functor' f where
    fmap' :: (a->b) -> f a -> f b

instance Functor' ((,) e) where
    fmap' g (e, x) = (e, g x)

-- g can only be applied to x and not to e, as it cannot be of type b
-- fmap' (\x->x*10) ("hello",2)
-- ("hello",20)

data Pair a = Pair a a

instance Functor' Pair where
    fmap' g  (Pair x y) =  Pair (g x) (g y)

-- g can  be applied to x and y as they would be of same type b, and more importantly
-- Pair is of type * -> *
