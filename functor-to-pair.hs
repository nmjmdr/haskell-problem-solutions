class Functor' f where
 fmap' :: (a -> b) -> f a -> f b

instance Functor' [] where
 fmap' _ [] = []
 fmap' f (x:xs) = (f x) : fmap' f xs

-- beatiful use of partial application on types:

instance Functor' ((,) a) where
 fmap' f (a,b) = (a,f b)
-- pattern match as series of partial applications does not work:
-- fmap' f (a,b) = ((,) a) b (f b)
