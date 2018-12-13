
sequenceAL :: (Monad f, Applicative f) => [f a] -> f [a]
sequenceAL [] = pure []
sequenceAL (x:xs) = do
                     y <- x
                     ys <- sequenceAL xs
                     pure ([y] ++ ys)

sequenceAL' :: Applicative f => [f a] -> f [a]
sequenceAL' [] = pure []
sequenceAL' (x:xs) = (:) <$> x <*> sequenceAL' xs

-- (:) <$> x <*> sequenceAL' xs can written as:

-- ((:) <$> x) <*> sequenceAL' xs
--  ((:) <$> x) is interpreted as of type f([a]->[a])
-- a computation content that append x to the input container [f a]
-- <*> transorms [f a] to a to give it as "x" to 

-- think of it as follows:
-- *Main> f x xs = (fmap (:) x) <*> xs
-- *Main> :info f
-- *Main> f :: Applicative f => f a -> f [a] -> f [a]
