-- Expression interpretor from "The essence of functional programming" - Phil Wadler

type Name = String
data Term = Var Name
          | Const Int
          | Add Term Term
          | Lam Name Term  -- A lambda expression \x = term
          | App Term Term  -- can only apply if first term is lambda


data Value  =  Wrong
               | Num Int
               | Func (Value -> Value)

type Env = [(Name,Value)]

showval :: Value -> String
showval Wrong = "<wrong>"
showval (Num i) = show i
showval (Func _) = "<function>"

lkup :: Name -> Env -> Value
lkup x [] = Wrong
lkup x ((n,v):e) = if n == x then v else lkup x e

add :: Value -> Value -> Value
add (Num i) (Num j) = Num (i + j)
add _  _ = Wrong

apply :: Value -> Value -> Value
apply (Func f) v = f v
apply _ _ = Wrong 

interpret :: Term -> Env -> Value
interpret (Var x) e = lkup x e 
interpret (Const i) e = (Num i)
interpret (Add u v) e = let a = interpret u e
                            b = interpret v e
                        in add a b
interpret (Lam x term) e = Func (\a -> interpret term ((x,a):e))
interpret (App term1 term2) e = apply (interpret term1 e) (interpret term2 e) -- assumption being (interpret term1 e - produces a (Func ..) expression)

-- Introducing Monad:

class Monad' m where
 bind' :: m a -> (a -> m b) -> m b
 return' :: a -> m a

newtype State s a = State { runState :: s -> (a,s) }

instance Monad' (State s) where
 bind' st f = State { runState = \s -> let (x,s') = (runState st) s in
                                          (runState (f x)) s' 
                    }
 return' x = State { runState = \s -> (x,s) }

add' :: (Monad' m) => m Value -> m Value -> m Value
add' u v = u `bind'` (\(Num a) -> v `bind'` (\(Num b) -> return' (Num (a+b) )))


interpret' :: (Monad' m) => Term -> Env -> m Value
interpret' (Var x) e = return' (lkup x e)
interpret' (Const i) e = return' (Num i)
interpret' (Add u v) e = (interpret' u e)  `bind'` (\a -> (interpret' v e) `bind'` (\b -> return' (add a b)))
-- alternatively can do: interpret' (Add u v) e =  (interpret' u e) `add'` (interpret' v e) 
-- interpret' (Lam x term) e = return' (Func (\a -> (interpret' term ((x,a):e)) `bind'` (\x -> x)))

