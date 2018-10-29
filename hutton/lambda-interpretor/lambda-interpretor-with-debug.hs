
type Name = String

data Term = Var Name
          | Con Int
          | Add Term Term
          | Lam Name Term
          | App Term Term

data Val = Wrong
           | Num Int
           | Fun (Val -> (Val,String)) -- A value that is a function thats transfroms value -> value

type Env = [(Name,Val)]

showval :: Val -> String
showval Wrong = "<wrong>"
showval (Num i) = show i
showval (Fun f) = "<function>"

interp :: Term -> Env -> (Val,String)
interp (Var x) e = (v, s ++ "interp called.") where (v, s) = lkup x e
interp (Con i) _ = (Num i, "interp called.")
interp (Add u v) e = (r, p' ++ s' ++ t' ++ "interp called.") where (r,  p') = add u' v' 
                                                                   (u', s') = (interp u e) 
                                                                   (v', t') = (interp v e)

interp (Lam x term) e = ((Fun (\a -> interp term ((x,a):e))), "interp called.")
-- Lam Name Term --> lamba x.x+10 = Lam x (x+10) = \a-> interp (x+10) ((x,a):e) where ((x,a):e) acts an envirornment 

interp (App term1 term2) e = (r, p ++ s ++ t ++ "interp called.")  where (r, p) = apply u v 
                                                                         (u, s) = (interp term1 e) 
                                                                         (v, t) = (interp term2 e)

lkup :: Name -> Env -> (Val,String)
lkup x [] = (Wrong,"lkup called.")
lkup x ((y,v):e) = if x == y then (v, "lkup called.") else lkup x e 

add :: Val -> Val -> (Val,String)
add (Num i) (Num j) = (Num (i+j), "add called.")
add _ _ = (Wrong, "add called.")

apply :: Val -> Val -> (Val,String)
apply (Fun f) a = (r, s ++ "apply called.") where (r,s) = f a
apply _ _  = (Wrong, "apply called.")


test :: Term -> (String,String)
test t = (showval r, show s) where (r, s) = (interp t [])

-- Now the key part is that to add exception handling, or to add debug statements we will have to end modifying the whhole program in different ways, hence Monads are introduced

-- test (App (Lam "x" (Add (Var "x") (Var "x"))) (Add (Con 11)(Con 10)))
-- ("42","\"add called.lkup called.interp called.lkup called.interp called.interp called.apply called.interp called.add called.interp called.interp called.interp called.interp called.\"")

-- The next step would be to introduce Monads to be able to perform more than just debugging

-- If we wanted execution couunt instead of debung statements, we would want return types as (Val, Int) instead of (Val, String)
-- The original functions would rather return Val, and we need a function that would change to the (Val, Int) or (Val, String)

-- As types (Val, Int) or (Val, String) differs based on the context in which it is used, we would want the type as the paramater =>
-- Val => type a Int, String -> type b then
-- a -> b 
-- How would we write such a function?
-- lkup :: Name->Env->(Val->(Val,b))->(Val,b)

