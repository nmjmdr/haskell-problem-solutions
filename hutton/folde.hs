data Expr = Val Int | Add Expr Expr

folde::(Int->a)->(a->a->a)->Expr->a
folde f _ (Val v) = f v
folde f g (Add e1 e2) = g (folde f g e1) (folde f g e2)

eval::Expr->Int
eval = folde (\x->x) (+)

size::Expr->Int
size = folde (\x->1) (+)

