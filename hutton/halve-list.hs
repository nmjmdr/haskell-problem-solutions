halveList::[x] -> ([x],[x])
halveList x =
 ((take half x), (drop half x))
 where half = fromIntegral (length(x) `div` 2)

