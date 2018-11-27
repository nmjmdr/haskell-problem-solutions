
data W a = W a deriving Show

returnW :: a -> W a
returnW x = W x

fmapW :: (a->b) -> W a -> W b
fmapW gn (W x) = W (gn x)

joinW :: W (W a) -> W a
joinW ws = (\(W x)->x) `fmapW` ws

-- Excercises from https://wiki.haskell.org/Typeclassopedia#Monad

-- implement bindW in terms of fmap and join
-- fmapW -- treats b as "W b", and returns W (W b), which join can then operate on
bindW :: (a -> W b) -> W a -> W b
bindW g = joinW . fmapW g 

bindW' :: (a -> W b) -> W a -> W b
bindW' g (W x) = g x 

-- implement join and fmap (liftM) in terms of (>>=) and return.
joinW' :: W (W a) -> W a
joinW' ws = (\u->u) `bindW'` ws 

fmapW' :: (a->b) -> W a -> W b
fmapW' g wx = (\x -> returnW $ g x) `bindW'` wx


