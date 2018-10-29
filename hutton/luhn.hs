luhnDouble::Int->Int
luhnDouble x =
 if y > 9 then y - 9 else y where y = x * 2

luhn::Int->Int->Int->Int->Bool
luhn a b c d =
 sum [d, luhnDouble c, b, luhnDouble a] `mod` 10 == 0
 
