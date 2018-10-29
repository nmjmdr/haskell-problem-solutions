module EqExamples where

data StringOrInt = TisInt Int | TisString String

instance Eq StringOrInt where 
 (==) (TisInt t1) (TisInt t2) = t1 == t2 
 (==) (TisString s1) (TisString s2) = s1 == s2


data Tuple a b = Tuple a b

instance (Eq a, Eq b) => Eq (Tuple a b) where
 (==) (Tuple a b) (Tuple p q) = (a == p) && (b == q)


data Pair a = 
 Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair x x') (Pair y y') = x == y && x' == y'


data Which a = ThisOne a | ThatOne a

instance (Eq a) => Eq (Which a) where
 (==) (ThisOne a) (ThisOne a') = a == a'
 (==) (ThatOne a) (ThatOne a') = a == a'
 (==) _ _ = False


data EitherOr a b = Hello a | Goodbye b

instance (Eq a, Eq b) => Eq (EitherOr a b) where
 (==) (Hello x) (Hello y) = x == y
 (==) (Goodbye x) (Goodbye y) = x ==y
 (==) _ _ = False



