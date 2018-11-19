
class Monoid' a where
 mempty' :: a
 mappend' :: a -> a -> a
 mconcat' :: [a] -> a
 mconcat' = foldr mappend' mempty'

data Any = Any Bool deriving Show
data All = All Bool deriving Show

instance Monoid' Any where
 mempty' = Any False
 mappend' (Any True) _ = Any True
 mappend' _ (Any True) = Any False


instance Monoid' All where
 mempty' = All False
 mappend' (All True) (All True) = All True
 mappend' _ _ = All False
