class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b
   

instance Functor' Maybe where
    fmap' _ Nothing = Nothing
    fmap' g (Just x) = Just (g x)


instance  Applicative' Maybe where
    pure' x = Just x
    app (Just f) (Just x) = Just (f x)
    app _ _ = Nothing
    
