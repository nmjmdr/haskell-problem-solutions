class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b

class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b


instance Functor' Maybe where
    fmap' _ Nothing = Nothing
    fmap' g (Just x) = Just (g x)

instance Applicative' Maybe where
    pure' x = Just x
    app (Just g) (Just x) = Just (g x)
    app _ _ = Nothing

instance Monad' Maybe where
    return' x = Just x
    bind' (Just x) g = g x
    bind' Nothing _ = Nothing

