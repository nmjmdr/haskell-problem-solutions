class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b

class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b


revbind :: Monad' m => (a -> m b) -> m a -> m b
revbind g x = bind' x g

-- more at: http://members.chello.nl/hjgtuyl/tourdemonad.html
