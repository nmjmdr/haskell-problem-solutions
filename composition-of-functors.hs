
class Functor' f where
    fmap' :: (a->b) -> f a -> f b

instance Functor' Maybe where
    fmap' _ Nothing = Nothing
    fmap' g (Just x) = Just (g x)

instance Functor' (Either a) where
    fmap' g (Left a) = Left a
    fmap' g (Right b) = Right (g b)


-- yes functors do compose, in the following manner:
-- fmap' (fmap' (\x->x+10)) (Just (Right 10))
-- Just (Right 20)

-- http://hackage.haskell.org/package/base-4.12.0.0/docs/Data-Functor-Compose.html