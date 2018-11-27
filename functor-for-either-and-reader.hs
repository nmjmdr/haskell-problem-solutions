class Functor' f where
 fmap' :: (a->b) -> f a -> f b


instance Functor' (Either a) where
 fmap' g (Left a) = Left a
 fmap' g (Right b) = Right (g b)
 

instance Functor' ((->) e) where
 fmap' g k = g . k

-- fmap' (\x->x+10) (1+) 10
-- 21

-- Example ((->) e) is partial type of ((->) a b) which is a function (a->b)
f :: ((->) a b) -> a -> b
f g x = g x

