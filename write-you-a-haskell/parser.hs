
import Control.Applicative
import Control.Monad

newtype Parser a = Parser { parse :: String -> [(a,String)] }


instance Functor Parser where
 fmap g (Parser pa) = Parser { parse = \s -> [(g a,s') | (a,s') <- pa s] }


instance Applicative Parser where
 pure x = Parser { parse = \s -> [(x,s)] }
 (<*>) (Parser pg) (Parser pa) = Parser { parse = \s -> [(g a,s'') | (g,s') <- pg s, (a, s'') <- pa s'] }



instance Monad Parser where
 return = pure
 (>>=) (Parser pa) g = Parser { parse = \s -> [(b,s'') | (a, s') <- (pa s), (b,s'') <- parse (g a) s'] } 

 -- Can be simplfied to: Parser $ \s -> concatMap (\(a, s’) -> parse (f a) s’) $ parse p s 

instance Alternative Parser where
    empty = mzero
    (<|>) = option

instance MonadPlus Parser where
 mzero = failure
 mplus = combine


failure :: Parser a
failure = Parser { parse = \_ -> []}

combine :: Parser a -> Parser a -> Parser a
combine (Parser px) (Parser py) = Parser { parse = \s -> (px s) ++ (py s) }

option :: Parser a -> Parser a -> Parser a
option (Parser px) (Parser py) = Parser { parse = \s -> case px s of 
                                                           [] -> py s
                                                           result -> result
                                        }


-- Derived automatically from the Alternative typeclass definition are the many and some functions. 

-- Many takes a single function argument and repeatedly applies it until the function fails and then yields the collected results 
-- up to that point. 

-- The some function behaves similar except that it will fail itself if there is not at least a single match.



satisfy' :: (Char -> Bool) -> Parser Char
satisfy' g = Parser { parse = \c -> if g $ head c 
                                    then [(head c, tail c)]
                                    else []
                   }
item :: Parser Char
item = Parser { parse = \s -> [(head s, tail s)] }

-- (>>=) (Parser Char) (Char -> Parser Char) -> (Parser Char)
satisfy :: (Char -> Bool) -> Parser Char
satisfy m = item >>= \c -> if m c 
                            then pure c
                            else Parser { parse = \_ -> [] }

-- *Main> p = satisfy (\c -> c == ' ')
-- *Main> parse p " hello"
-- [(' ',"hello")]
-- *Main>


-- chainl1 p op = do { a <- p; 
--                     b <- op;
--                     return b;
--                   }       
                  
-- leads to:
-- *Main> f s = ([head s],tail s)
-- *Main> p = Parser { parse = \s -> [f s] }
-- *Main> parse (chainl1 p p) "hello"
-- [("e","llo")]

-- chainl1 p op = do { a <- p; 
--                     return a;
--                   }       
                  
-- leads to:
-- *Main> f s = ([head s],tail s)
-- *Main> p = Parser { parse = \s -> [f s] }
-- *Main> parse (chainl1 p p) "hello"
-- [("h","ello")]

chainl1 :: Parser a -> Parser (a -> a -> a) -> Parser a
p `chainl1` op = do  { a <-p; rest a}
 where rest a = ( do f <- op 
                     b <- p
                     rest (f a b)
                )
                <|> return a

-- *Main> sp = satisfy (\c->c==' ')
-- *Main> sh = satisfy (\c->c=='h')
-- *Main> f = (chainl1 p p)

-- Main> f = (chainl1 sp sh)
-- *Main> parse f " hello"
-- []
-- *Main> parse f "  hello"
-- []
-- *Main> parse f " h ello"
-- [(' ',"ello")]