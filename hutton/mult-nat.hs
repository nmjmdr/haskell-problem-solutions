data Nat = Zero | Succ Nat deriving Show

nat2int::Nat->Int
nat2int Zero = 0
nat2int (Succ n) = 1 + nat2int n

int2nat::Int->Nat
int2nat 0 = Zero
int2nat n = Succ (int2nat (n-1))

add::Nat->Nat->Nat
add m Zero = m
add Zero n = n
add (Succ m) n = Succ (add m n)

mult::Nat->Nat->Nat
mult _ Zero = Zero
mult Zero _ = Zero
mult m (Succ n) = add m (mult m n)
 
