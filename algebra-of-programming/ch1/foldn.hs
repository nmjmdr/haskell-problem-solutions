module FoldN where

foldn::(Num n, Eq n) => a->(a->a)->(n->a)
foldn c h = f where
 f 0 = c 
 f n =  h . f $ n-1


fc::(Num b)=>(b,b) -> (b,b)
fc (m,n)  = (m+1, (m+1) * n )


fact::(Num x, Eq x)=>x->x
fact x = snd ((foldn (0,1) fc) x)

fact'::(Num a, Eq a)=>a->a
fact' 0 = 1
fact' x = x * fact' (x-1)



fb::(Num a)=>(a,a)->(a,a)
fb (m,n) = (n, m + n)

fib::(Num x, Eq x)=>x->x
fib x = fst ( (foldn (0,1) fb) x )

fib'::(Num a, Eq a)=>a->a
fib' 0 = 0
fib' 1 = 1
fib' n = fib' n-1 + fib' n-2
 
 





