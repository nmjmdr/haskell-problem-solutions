
class Join' f where
 join' :: f (f a) -> f a

instance Join' Maybe where
 join' Nothing = Nothing
 join' (Just x) = x

instance Join' IO where
 join' x = do 
            y <- x
            y

-- join' (fmap putStrLn getLine)



