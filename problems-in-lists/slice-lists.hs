

slicelist :: Int -> Int -> [a] -> [a]
slicelist _ _ [] = []
slicelist 0 0 (x:xs) = [x]
slicelist 0 j (x:xs) = [x] ++ slicelist 0 (j-1) xs
slicelist i j (x:xs) = slicelist (i-1) j xs

                                                     
                                               
                          
