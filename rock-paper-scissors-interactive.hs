import System.Random

data Move = Rock | Paper | Scissors | None deriving (Eq, Show)

computerMove :: IO Move
computerMove = do 
   r <- randomRIO (0,2)
   return ([Rock, Paper, Scissors] !! r)

parseInput :: String -> Move
parseInput "Rock" = Rock
parseInput "Paper" = Paper
parseInput "Scissors" = Scissors
parseInput _ = None 

userMove :: IO Move
userMove = do
 putStrLn "Enter your move: "
 r <- getLine
 return (parseInput r)

data Outcome = Win | Lose | Draw deriving Show 

compareMoves :: Move -> Move -> Outcome
compareMoves a b | a == b = Draw
                 | a == Paper && b == Rock = Win
                 | a == Scissors && b == Paper = Win
                 | a == Rock && b == Scissors = Win
                 | otherwise = Lose


-- Rock Scissors = Win
-- compareMoves Scissors Paper = Win
-- compareMoves Paper Rock = Win
-- comapreMoves _ _ = Lose
 

play :: IO Outcome
play = do
 u <- userMove
 r <- computerMove
 o <- return (compareMoves u r)
 putStrLn ("Computer: "++(show r))
 return o



