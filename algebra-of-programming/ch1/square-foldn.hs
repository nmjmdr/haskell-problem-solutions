module SquareInFoldN where

-- Express the squaring function sqr : Nat«—Nat in the form sqr = f -foldn (c, h) for suitable /, c and h.

foldn::(Num n, Eq n) => a->(a->a)->(n->a)
foldn c h = f where
 f 0 = c
 f n =  h . f $ n-1



fs::(Num a)=>(a,a)->(a,a)
fs (m,n) = (m+n,n)


sq::(Num a, Eq a)=>a->a
sq x = fst( (foldn (0,x) fs) x)

