module ClassExamples where

class Check a where
 checkedAdd :: a->a->a

instance Check Integer where
  checkedAdd = (+)

instance Check Int  where
 checkedAdd = (+)

-- The following do not work, figure out solutions:
-- instance Check Fractional where
--  checkedAdd = (+)

-- instance Check String where
--  checkedAdd = (++)


f::Check a=> a->a->a
f x y = checkedAdd x y

g::Int->Int->Int
g a b = a+b

h::Num a=> a->a->a
h a b = a+b





 
