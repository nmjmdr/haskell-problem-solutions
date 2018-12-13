
g :: a -> b -> (a,b)
g x y = (x,y)


h = g .const

fn x lx = fmap (const x) lx

-- This is the way to think about
-- (<$) :: a -> f b -> f a
-- ==> (<$) = fmap . const 
-- ==> (<$) x ly = fmap (const x) ly

