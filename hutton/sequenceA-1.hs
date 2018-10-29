class Applicative' f where
 pure' :: a -> f a
 app :: f (a->b) -> f a -> f b


instance Applicative' [] where
 pure' x = [x]
 app gs xs = [(g x) | g <- gs, x <- xs]

sequenceA' :: Applicative' f => [f a] -> f [a]
sequenceA' [] = pure' []
sequenceA' (x:xs) = app (app (pure' (:)) x) (sequenceA' xs)

instance Applicative' IO where
 pure' = return
 app mg mx = do { g <- mg; x <- mx; return (g x)}

