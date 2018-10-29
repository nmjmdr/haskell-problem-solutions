data Move = Rock | Paper | Scissors

instance Eq Move where
 (==) (Rock) (Rock) = True
 (==) (Paper) (Paper) = True
 (==) (Scissors) (Scissors) = False
 (==) _ _ = False

 


instance Ord Move where
 compare (Scissors) (Paper) = GT
 compare (Rock) (Scissors) = GT
 compare (Paper) (Rock) = GT
 compare a b = if a == b then EQ else LT
 
data Outcome = Win | Lose | Draw deriving Show

makeMove :: Move->Move->Outcome
makeMove m1 m2 | m1 > m2 = Win
               | m1 == m2 = Draw
               | otherwise = Lose


 
