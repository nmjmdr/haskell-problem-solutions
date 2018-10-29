
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

-- This version keeps a trace of lkup calls as string "lkup called."
lkups :: Name -> Env -> String -> (Val, String) 
lkups x [] s = (Wrong, s ++ "lkup called.")
lkups x ((y,v):e) s = if x == y then (v, s ++ "lkup called.") else lkups x e s

-- This version keeps a count how many times lkup was called
lkupi :: Name -> Env -> Int->(Val, Int)
lkupi x [] c  = (Wrong, (c+1))
lkupi x ((y,v):e) c  = if x == y then (v, (c+1)) else lkupi x e (c+1)

lkpug :: Name -> Env -> t -> (t->t)->(Val, t)
lkupg x [] i f = (Wrong, i') where i' = f i
lkpug x ((y,v):e) i f = if x == y then (v, i') else lkupg x e i' f where i' = f i

-- we can now write lkups as:
lkups' :: Name -> Env -> String -> (Val, String)
lkups' x e s = lkupg x e s (\a -> a ++ "lkup called.")

-- we can now write lkupi as:
lkpupi' :: Name -> Env -> Int -> (Val, Int)
lkpupi' x e c = lkupg x e c (\a -> a + 1)

