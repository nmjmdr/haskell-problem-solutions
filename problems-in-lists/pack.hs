
pack :: Eq a => [a] -> [[a]]
pack xs = foldr (\x acc -> case acc of
                            [] -> [[x]]
                            (l:ls) -> if head l == x then [l ++ [x]] ++ ls else [[x]] ++ (l:ls)) [] xs

    
