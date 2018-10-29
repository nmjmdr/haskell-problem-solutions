safediv::Int->Int->Maybe Int
safediv _ 0 = Nothing
safediv m n = Just (m `div` n)
