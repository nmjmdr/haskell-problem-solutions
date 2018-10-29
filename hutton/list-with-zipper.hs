data List a = Empty | Cons a (List a) deriving Show

data Step a = Step a deriving Show
type Thread a = [Step a]

type Zipper a = (Thread a,List a)

move::Zipper a -> Maybe (Zipper a)
move ([],l) = Just ([],l)
move (z,Empty) = Nothing
move (z, (Cons a l)) = Just (Step a:z,l) 

back::Zipper a -> Maybe (Zipper a)
back ([],l) = Nothing
back ((Step x):th,l) = (th, (Cons x l))



