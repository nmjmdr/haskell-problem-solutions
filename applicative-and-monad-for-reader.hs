class Functor' f where
    fmap' :: (a->b) -> f a -> f b
   

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b
       

class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b

   
instance Functor' ((->) e) where
    fmap' g k = g . k

-- f is ((->) e)
-- f a is (e->a)
-- then think about the following, then it makes sense

instance Applicative' ((->) e) where
    pure' x = \_ -> x
    app g h = \r -> (g r) (h r) 

instance Monad' ((->) e) where
    return' x = \_ -> x
    bind' g h = \r -> (h (g r)) r




