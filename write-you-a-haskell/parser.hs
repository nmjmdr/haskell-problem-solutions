
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
