-- This doesnt work yet

class Eq' a where
 eq :: a->a->Bool
 neq :: a->a->Bool

instance Eq' a => Eq' (Maybe a) where
  eq (Just a) (Just b) = (a eq b)
  eq (Nothing) _ = False
  eq _ (Nothing) = False 
