
type Name = String

data Term = Var Name
          | Con Int
          | Add Term Term
          | Lam Name Term
          | App Term Term

data Val = Wrong
           | Num Int
           | Fun (Val -> Val) -- A value that is a function thats transfroms value -> value

type Env = [(Name,Val)]

showval :: Val -> String
showval Wrong = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

interp :: Term -> Env -> Val
interp (Var x) e = lkup x e
interp (Con i) _ = Num i
interp (Add u v) e = add (interp u e) (interp v e)

interp (Lam x term) e = Fun (\a -> interp term ((x,a):e)) 
-- Lam Name Term --> lamba x.x+10 = Lam x (x+10) = \a-> interp (x+10) ((x,a):e) where ((x,a):e) acts an envirornment 

interp (App term1 term2) e = apply (interp term1 e) (interp term2 e)

lkup :: Name -> Env -> Val
lkup x [] = Wrong
lkup x ((y,v):e) = if x == y then v else lkup x e 

add :: Val -> Val -> Val
add (Num i) (Num j) = Num (i+j)
add _ _ = Wrong

apply :: Val -> Val -> Val
apply (Fun f) a = f a
apply _ _  = Wrong


test :: Term -> String
test t = showval (interp t [])

-- Now the key part is that to add exception handling, or to add debug statements we will have to end modifying the whhole program in different ways, hence Monads are introduced

