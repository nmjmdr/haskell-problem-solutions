

data List' a = None | Cons a (List' a) deriving Show

class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b

class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b

instance Functor' List' where
    fmap' _ (None) = None
    fmap' g (Cons x xs) = Cons (g x) (fmap' g xs)

instance Applicative' List' where
    pure' x = Cons x (None)
    app (Cons g lg)  (Cons x lx) = Cons (g x) (app lg lx)
    app _ _ = None

appendElement :: List' a -> a -> List' a
appendElement None x = Cons x (None)
appendElement (Cons l ls) x = Cons l (appendElement ls x)


appendLists :: List' a -> List' a -> List' a
appendLists None ly = ly
appendLists (Cons x lx) ly = Cons x (appendLists lx ly)


instance Monad' List' where
    return' x = Cons x None
    bind' (Cons x l) g = (g x)  `appendLists` (bind' l g)
    bind' _ _ = None 

class Monoid' a where
    mempty' :: a
    mappend' :: a -> a -> a

class Foldable' t where
    foldMap' :: Monoid' m => (a -> m) -> t a -> m

instance Foldable' List' where
    foldMap' g lx = 