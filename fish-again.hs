
-- (>>=) :: IO a -> (a -> IO b) -> IO b

class Fish f where
 (>>=>>) :: f a -> (a -> f b) -> f b

instance Fish Maybe where
 (>>=>>) Nothing _ = Nothing
 (>>=>>) (Just x) fn = fn x

-- (>>=>>) (Just 1) (\x -> Just (x+1))

class ExecFirstGetResultNext f where
 (>->) :: f a -> f b -> f b

-- implementing (>->) using (>>=>>) : 
instance ExecFirstGetResultNext Maybe where
 (>->) x y = (>>=>>) x (\_ -> y)


