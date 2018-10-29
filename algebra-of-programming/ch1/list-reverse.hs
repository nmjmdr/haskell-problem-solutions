module ListReverse where

data List a = Nil | Cons a (List a) deriving Show

data Tsil a = Lin | Snoc (Tsil a) a deriving Show




listToTsil::(List a)->(Tsil a)
listToTsil Nil = Lin 
listToTsil (Cons a l) = snocIt a (listToTsil l)

snocIt::a->(Tsil a)->(Tsil a)
snocIt a Lin = Snoc Lin a
snocIt a l = Snoc l a

 
