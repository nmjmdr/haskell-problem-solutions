import System.Random

guess :: Int -> Int -> Int -> IO ()
guess n x turns = do
                   case (compare x n)of
                    EQ -> putStrLn ("Got it! You took " ++ (show turns) ++ " turns")
                    LT -> do
                           putStrLn "Guess higher: "
                           x <- ask 
                           guess n x (turns + 1)
                    GT -> do
                           putStrLn "Guess lower"
                           x <- ask
                           guess n x (turns + 1)

ask :: IO Int
ask = do 
       r <- getLine
       let x = read r :: Int
       return x

play :: IO ()
play = do 
         putStrLn "Guess (1 - 100): "
         n <- randomRIO (1, 100)
         x <- ask
         guess n x 1
         


