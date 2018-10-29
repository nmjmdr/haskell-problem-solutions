data T1 f a = T1 (f a)

g :: Int->Int
g x = x + 2


extractApply (T1 f) x = (f x)

-- *Main> t = T1 g
-- *Main> :info t
-- t :: T1 ((->) Int) Int 	-- Defined at <interactive>:10:1
-- *Main> extractApply t 100
-- 102
