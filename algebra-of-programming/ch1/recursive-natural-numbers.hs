module RecursiveNaturalNumbers where

data Nat = Zero | Succ Nat deriving Show

plus::Nat->Nat->Nat
plus m Zero = m
plus m (Succ n) = Succ (plus m n )


minus::Nat->Nat->Nat
minus Zero Zero = Zero
minus m Zero = m
minus Zero m = undefined 
minus (Succ m) (Succ n) = minus m n

