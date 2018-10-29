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

sub::Nat->Nat->Maybe Nat
sub m Zero = Just m
sub Zero n = Nothing
sub (Succ m) (Succ n) = sub m n

