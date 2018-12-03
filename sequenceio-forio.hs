-- for : init value, end condition function, increment function, IO function, returns IO action 

generate :: a -> (a->Bool) -> (a->a) -> [a]
generate s cnd incr = if (cnd s) then [] else [s] ++ generate (incr s) cnd incr



sequenceIO :: [IO a] -> IO [a]
sequenceIO [] = return []
sequenceIO (x:xs) = do
                     x' <- x
                     xs' <- sequenceIO xs
                     return ([x'] ++ xs')   


myprint :: Show a => a -> IO a
myprint x = do 
             print x      -- or,  print x >> return x
             return x

for::a->(a->Bool)->(a->a)->(a->IO())->IO()
for s cnd incr ioFn = sequence_ (map (ioFn) (generate s cnd incr))

for'::a->(a->Bool)->(a->a)->(a->IO a)->IO [a]
for' s cnd incr ioFn = sequenceIO (map (ioFn) (generate s cnd incr))

-- for' 1 (\i->i==10) (\i->i+1) (myprint) <= works
-- Refer: https://stackoverflow.com/questions/53002212/haskell-no-instance-of-num-defining-my-own-monadic-loop

mapIO :: (a -> IO b) -> [a] -> IO [b]
mapIO _ [] = return []
mapIO f (x:xs) = do 
                   x' <- f x
                   xs' <- mapIO f xs
                   return ([x'] ++ xs')
 
