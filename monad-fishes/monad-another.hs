data Maybe' m = Just' m | Nothing'

class Monad' m where
 bind' :: m a -> (a -> m b) -> m b
 return' :: a -> m a

instance Monad' (Maybe') where
 bind' (Just' x) f = f x
 bind' (Nothing') f = Nothing'
 return' x = Just' x

d
