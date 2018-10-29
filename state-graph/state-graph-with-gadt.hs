{-# LANGUAGE GADTs #-}


data Val a where 
         IntVal :: Int -> Val Int
         FloatVal :: Float -> Val Float
         StringVal :: String -> Val String

data List a = List [Val a]


