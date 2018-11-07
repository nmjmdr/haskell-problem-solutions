
type Operand = Double

data Operator = Plus | Minus | Mult | Sub | Div deriving Show

data Expression = Expression [Operand] [Operator] deriving Show

toOperator :: String -> Maybe Operator
toOperator "+" = Just Plus
toOperator "-" = Just Sub
toOperator "*" = Just Mult
toOperator "/" = Just Div
toOperator _ = Nothing

isOperator :: String -> Bool
isOperator x = case (toOperator x) of
                (Just _) -> True
                otherwise -> False

getOperator :: String -> Operator
getOperator x = case (toOperator x) of
                (Just op) -> op
                otherwise -> error "Could not convert to operator"

toDouble :: String -> Double
toDouble x = let r = reads x :: [(Double,String)] in case r of
                                                      [] -> error "Unable to parse to double"
                                                      _ -> fst (head r)


push :: [a] -> a -> [a]
push stack x = [x] ++ stack

pop :: [a] -> (a, [a])
pop [] = error "Stack empty, cannot pop"
pop (x:xs) = (x,xs)

execute :: Double -> Double -> Operator -> Double
execute x y op = case op of 
                  Plus -> x + y
                  Sub -> x - y
                  Mult -> x * y
                  Div -> x / y

applyOperator :: [Double] -> Operator -> [Double]
applyOperator [] _ = error "Cannot apply operator, stack is empty"
applyOperator [x] _ = error "Cannot apply operator, stack has only one operand"
applyOperator stack op = push st2 (execute x y op) where 
                                                    (x, st1) = pop stack 
                                                    (y, st2) = pop st1

isOperand :: String -> Bool
isOperand x = length (reads x :: [(Double,String)]) > 0 

-- eval :: [String] -> Double
eval xs = fst (pop (foldl (\stack x -> if isOperand x 
                              then push stack (toDouble x)
                             else applyOperator stack (getOperator x)
                          ) [] xs))
