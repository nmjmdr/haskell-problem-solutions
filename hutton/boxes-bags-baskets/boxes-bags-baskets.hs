data Box x = Box x deriving Show 
data Bag x = Bag x deriving Show
data Basket x = Basket x deriving Show


-- Operate on the contents of the box, bag or basket
-- We want to be able to define a function such as operate :: (a->b) ->f a -> f b, so that we can operate on the contents of any container
-- Let us try to define operate as below:
-- operate :: (a->b) -> f a  -> f b
-- operate fn (t a) = t (fn a)
-- The above does not work, as it fails to pattern much (t a) (Parse error in pattern: (t a)
-- Question is, why cannot Haskell interpret it? or is it an issue of syntax?

-- We could define a Functor which can accomplis this
class Functor' f where
 fmap' :: (a->b) -> f a -> f b

instance Functor' Box where
 fmap' fn (Box x) = Box (fn x) 

instance Functor' Bag where
 fmap' fn (Bag x) = Bag (fn x)

instance Functor' Basket where
 fmap' fn (Basket x) = Basket (fn x)

-- using this we can ne define operations on a series of containers:
-- *Main> map (fmap' (\x->x+1)) [(Box 1),(Box 2)]
-- [Box 2,Box 3]
-- *Main
seriesFmap' :: Functor' f => (a -> b) -> [f a] -> [f b]
seriesFmap' fn = map (fmap' fn)

-- Can we combine two or more containers, into a single container by putting the individual containers things together
-- (Box 1), (Box 3) => Box 4
-- (Bag "hello"), (Bag " ") (Bag "world") => Bag "hello world"

-- Note that we should be able take in as input a "function" that can put things together. This function should know how to put things of "type" contained in the container. 
-- Thus for putting strings togther it would be : \x y -> x++y, for ints it would be: \x y -> x+y
-- It may also be able to put things of different types together, thus (Box 1), (Box True) => Box 2, 
-- where 
-- fn x y = 
--  fn x True = x + 1
--  fn x _ = x

-- The number of inputs that such a "function" has to take depends on the number of containers it is attempting to put together

-- So we want to put together: Box 1, Box True
-- Start with not having to put anything together, but changes its type
-- pack1 (a->b) -> f a -> f b 
-- pack1 fn ta = pack fn (unpack ta)

-- pack2 (a->b->c) -> f a -> f b -> f c
-- pack2 fn ta tb = pack fn ((unpack ta) (unpack tb))

-- pack3 (a->b->c->d) -> f a -> f b -> f c -> f d
-- pack3 fn ta tb tc = pack fn ((unpack ta) (unpack tb) (unpack tc))

-- unpack :: f a -> a
-- pack :: a -> f a


class Applicative' f where
 pack :: a -> f a
 unpack :: f a -> a

instance Applicative' Box where
 pack x = Box x
 unpack (Box x) = x

instance Applicative' Bag where
 pack x = Bag x
 unpack (Bag x) = x

instance Applicative' Basket where
 pack x = Basket x
 unpack (Basket x) = x

pack1::(Applicative' f)=>(a->b)->f a->f b
pack1 fn ta = pack (fn (unpack ta))

pack2::(Applicative' f)=>(a->b->c)->f a->f b->f c
pack2 fn ta tb = pack(fn (unpack ta) (unpack tb))

-- what should be possibe to be done:
-- *Main> somefn (\x->x+1) (Box 2)
-- Box 3
-- *Main> somefn (\x->\y->x+y) (Box 1) (Box 2)
-- somefn (\x->\y->\z->x+y+z) (Box 1) (Basket 2) (Bag 3) ? -- Need to think more on this
-- base case someFn (f) [] = where f would return value k, which could then be packed. This could be inferred from the fact that there are no parameters to unpack in the array

-- so the base case is someFn (f) [] = pack (f())
-- recursive case is: someFn (f) (x:xs) = someFn (f unpack(x)) xs
-- First lets consider only a single type, hence all instructions of type: somefn (\x->\y->\z->x+y+z) (Box 1) (Box 2) (Box 3)

- Reference: https://stackoverflow.com/questions/50852592/looking-for-a-function-similar-sequencea


