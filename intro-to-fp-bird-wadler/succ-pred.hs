data Exp = Zero | Succ Exp | Pred Exp | AddOne Exp | SubOne Exp deriving Show


reduce::Exp->Exp
reduce (Succ(Pred e)) = reduce e
reduce (Pred(Succ e)) = reduce e
reduce e = e 

 

