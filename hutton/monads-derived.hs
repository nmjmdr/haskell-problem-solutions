f:: Float -> (Float,String)
f x = (x+1, "f was called.")

g:: Float -> (Float,String)
g x = (x+2, "g was called.")

bind' :: (Float->(Float,String))->(Float->(Float,String))->Float->(Float,String)
bind' fx gx x = (v,s++t) 
                where
                 (v,t) = gx u  
                 (u,s) = fx x

-- composing f and g => f (g x)
-- We wouuld have to write

composedFG :: Float->(Float,String)
composedFG x = (v, s++t)
                where 
                 (v, t) = f u 
                 (u, s) = g x

-- In order to compose any given f and g
-- we can defined bind which takes f and output of g and apply f to output of g, and combine debug strings of f and g
bind :: (Float->(Float,String))->(Float,String)->(Float,String)
bind f (gx,gs) = (v, gs++t) 
                  where (v,t) = f gx

-- bind f (g 100)
-- (103.0,"g was called.f was called.")

-- The second version of bind is simpler
-- Another advantage is the following
-- Now output of can be partially applied:
composedFG' = bind f . g

-- composedFG' 100
-- (103.0,"g was called.f was called.")

unit :: a->(a,String)
unit x = (x, "")

p :: Float -> Float
p x = x + 1

q :: Float -> Float
q x = x + 2

lift :: (a->a) -> (a->(a,String))
lift f = unit . f

data Complex = Complex Float deriving Show

sqrt' :: Complex -> [Complex] -- two roots
sqrt' (Complex x) = [Complex (x*2), Complex (x*4)] 

cbrt' :: Complex -> [Complex] -- three roors
cbrt' (Complex x) = [Complex (x+1), Complex (x+2), Complex (x+3)]

-- We want to be able to define 6th root of a complex number as cbrt' (sqrt' x) -- which has six roots, the cube roots of two square roots

-- We should be able to define a bind function for this

-- bind fn [complex] -> [complex] 
-- applies fn to each element in list [complex] and concacts the results to return [complex]

bind'' :: (Complex -> [Complex]) -> [Complex] -> [Complex]
bind'' fn cs = [ y | x <- cs, y <- fn x ]


-- *Main> sx = bind'' sqrt' . cbrt'
-- *Main> sx (Complex 10)
-- [Complex 22.0,Complex 44.0,Complex 24.0,Complex 48.0,Complex 26.0,Complex 52.0]

unit'' :: a -> [a]
unit'' x = [x]


-- randomized functions
-- data StdGen = StdGen x
frand :: a -> StdGen -> (b, StdGen)
frand = undefined

