class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b

class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b

(>=>) :: Monad' m => (a -> m b) -> (b -> m c) -> (a -> m c)
(>=>) g h = \x -> (return' x) `bind'` g `bind'` h

-- laws of monads can be expressed using the fish:
-- return >=> g  =  g
-- g >=> return  =  g
-- (g >=> h) >=> k  =  g >=> (h >=> k)