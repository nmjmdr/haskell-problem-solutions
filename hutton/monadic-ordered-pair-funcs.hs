


fn :: Num a => a -> (a,a)
fn x = (x+1, x-1)

gn :: Num a => a -> (a,a)
gn x = (x*10, x*20)

hn :: Num a => a -> (a,a)
hn x = (x+10, x-10)

-- Is it possible to chain these functions
-- first attempt to perform sequence of function applications without using bind

seq' :: (a->(a,a))->(a->(a,a))->a->[a]
seq' f1 f2 u =  [v,x] 
                 where 
                  (x, y) = f2 v 
                  (v, w) = f1 u

-- How do we extend this to apply any number of sequential operations?
-- Ideally should be able to do:
-- (fn >> gn >> hn) x = [q,r,s]
-- fn `bind` \q -> gn `bind` -> \r -> `bind` hn -> \s -> result [q,r,s]

class Monad' m where
 result :: a -> m a
 bind :: m a -> (a -> m b) -> m b


instance Monad' 
