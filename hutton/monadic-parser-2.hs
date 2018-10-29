import Data.Char

-- different types of Parsers:
-- type Parser = String -> Maybe (String, String)
-- type Parser = String -> Maybe (Tree, String)
-- type Parser = String -> Maybe (Int, String)

-- can be generalized as:

data Parser a = Parser (String -> Maybe (a, String))

class Monad' m where
 result :: a -> m a
 bind :: m a -> (a -> m b) -> m b

instance Monad' Parser where
 result v = Parser (\input -> Just (v, input))
 bind (Parser fa) fb = Parser (\input ->
                                 case (fa input) of
                                  Nothing -> Nothing
                                  Just(v, input') -> pb input' where (Parser pb) = fb v 
                              )
unbox :: Parser String -> (String -> Maybe (String, String))
unbox (Parser f) = f

capFirst :: Parser String
capFirst = Parser (\input -> case input of
                               [] -> Nothing
                               (x:xs) -> Just([toUpper(x)], xs) 
                  )


firstWithZero :: Parser String
firstWithZero = Parser (\input -> case input of
                               [] -> Nothing
                               (_:xs) -> Just("0", xs)
                  )



capAndZero = capFirst `bind` \x1 -> firstWithZero 


-- unbox(capAndZero) "hello"
-- prints Just("0", "llo")

capAndZeroSeq = capFirst `bind` \x1 ->
                firstWithZero `bind` \x2 ->
                capFirst

-- unbox(capAndZeroSeq) "hello"
-- Just ("L","lo")

capAndZeroSeq' = capFirst `bind` \x1 ->
                 firstWithZero `bind` \x2 ->
                 capFirst `bind` \x3 -> result (concat [x1,x2,x3])

-- unbox(capAndZeroSeq') "hello"
-- Just ("H0L","lo")
