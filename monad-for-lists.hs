class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b
   
class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b

instance Functor' [] where
   fmap' _ [] = []
   fmap' g (x:xs) = [(g x)] ++ fmap' g xs


instance  Applicative' [] where
    pure' x = [x]
    app gs xs = [g x | g <- gs, x <- xs]

instance Monad' [] where
    return' x = [x]
    bind' [] _ = []
    bind' (x:xs) g = (g x) ++ bind' xs g
