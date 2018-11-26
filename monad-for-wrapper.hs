class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b

class Applicative' m => Monad' m where
    return' :: a -> m a
    bind' :: m a -> (a -> m b) -> m b


data W a = W a deriving Show

-- for the user of this data type:
-- We can wrap things but we can't unwrap them. We still want to be able to whatever we like to the wrapped data

-- We can provide helper functions that help the user work with this wrapped data type

returnW :: a -> W a
returnW x = W x

fmapW :: (a->b) -> W a -> W b
fmapW g (W x) = W (g x)

f :: Int -> W Int
f x = W (x+1)

-- now try and apply f twice
-- cant use fmap as it expects a (a->b)

-- Something that can work with (a->W b)
-- Thus someFn :: (a -> W b) -> W a -> W b
someFn :: (a -> W b) -> W a -> W b
someFn = undefined

f2 :: Int -> W Int
f2 x = someFn f (f x)

f3 :: Int -> W Int
f3 x = someFn f (someFn f (f x)) -- and so on..

-- someFn is nothing but the monadic bind function
bindW :: (a -> W b) -> W a -> W b
bindW g (W x) = g x

fW3 :: Int -> W Int
fW3 x = bindW f (bindW f (f x))

-- excercise define a function g :: Int -> W Int -> W Int so that g x (W y) = W (x+y). 
-- Obviously that definition won't do - the left hand side has a W y pattern so it's actually unwrapping. 
-- Rewrite this function so that the only unwrapping that happens is carried out by bind.
g :: Int -> W Int -> W Int
g x wy = bindW (\y -> returnW (x + y)) wy

-- define a function h :: W Int -> W Int -> W Int so that h (W x) (W y) = W (x+y). Again, no unwrapping.
h :: W Int -> W Int -> W Int 
h wx wy = bindW (\x -> bindW (\y -> returnW (x+y)) wy ) wx


-- defining instances for W

instance Functor' W where
    fmap' g (W a) = W (g a)

instance Applicative' W where
    pure' x = W x
    app (W g) (W x) = W (g x)

instance Monad' W where
    return' x = W x
    bind' (W x) fn = fn x

-- excercise -- define a function join :: W (W a) -> W a using the Monad API and no explicit unwrapping.
joinW :: W (W a) -> W a
joinW ws = ws `bind'` (\u -> u)
