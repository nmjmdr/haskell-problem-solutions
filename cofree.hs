
data Rec f a = Rec a (f (Rec f a))

l = Rec 1 (Just (Rec 2 Nothing))

-- r = Rec 1 (id (Rec 2 (id 3   ... cannot end this

-- f is of type -> f :: * -> *

data Fdash a = Fdash a | None

f = Rec 1 (Fdash (Rec 2 (None)))


