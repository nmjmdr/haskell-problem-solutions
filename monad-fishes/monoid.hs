class Monoid' m where
 mempty' :: m
 mappend' :: m -> m -> m
 mconcat' :: [m] -> m
 mconcat' = foldr mappend' mempty'

data String' = String' [Char] deriving Show


instance Monoid' String' where
 mempty' = String' ""
 mappend' (String' a) (String' b) = String' (a++b)
 

data Sum' = Sum' Int deriving Show
data Product' = Product' Int deriving Show

instance Monoid' Sum' where
 mempty' = Sum' 0
 mappend' (Sum' a) (Sum' b) = Sum' (a + b)

data First a = First (Maybe a) deriving Show
data Last a = Last (Maybe a) deriving Show

instance Monoid' (First a) where
 mempty' = First (Nothing)
 mappend' (First (Nothing)) y = y
 mappend' x _ = x

data All = All Bool deriving Show
data Any = Any Bool deriving Show

instance Monoid' All where
 mempty' = All True
 mappend' (All True) (All True) = All True
 mappend' _ _ = All False

instance Monoid' Any where
 mempty' = Any False
 mappend' (Any False) (Any False) = Any False
 mappend' _ _ = Any True

data Maybe' a = Just' a | Nothing' deriving Show

instance (Monoid' a) => Monoid' (Maybe' a) where
 mempty' = undefined
 mappend' = undefined



