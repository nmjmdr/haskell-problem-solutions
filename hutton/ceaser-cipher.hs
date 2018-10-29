import Data.Char

let2int::Char->Int
let2int c = ord c - ord 'a'

int2let::Int->Char
int2let n = chr (ord 'a' + n)

shift::Char->Int->Char
shift c n
 | isLower c = int2let ( (let2int(c) + n) `mod` 26)
 | otherwise = c


encode::[Char]->Int->[Char]
encode xs n = [ shift x n | x <- xs]

lowers::[Char]->Int
lowers xs = sum [1 | x <- xs, x >= 'a' && x <= 'z']

percentage::Int->Int->Float
percentage n m = (fromIntegral n / fromIntegral m) * 100

count::Char->[Char]->Int
count x xs = sum [1 | x' <-xs, x' == x]

freqs::[Char]->[Float]
freqs xs = [percentage (count x xs) n | x <- ['a'..'z']] 
           where n = lowers xs

chisqr::[Float]->[Float]->Float
chisqr os es = sum [ ((o-e)^2)/e | (o,e) <- zip os es]

rotate::Int->[a]->[a]
rotate n xs = drop n xs ++ take n xs

positions::Eq a=> a -> [a] -> [Int]
positions x xs = [ y' | (x',y') <- zip xs [0..], x' == x]

table::[Float]
table = [12.02,9.1,8.12,7.68,7.31,6.95,6.28,6.02,5.92,4.32,3.98,2.88,2.71,2.61,2.3,2.11,2.09,2.03,1.82,1.49,1.11,0.69,0.17,0.11,0.1,0.07]

crack::String -> String
crack xs = encode xs (-factor)
           where 
            factor = head (positions (minimum chitab) chitab)
            chitab = [chisqr (rotate n table') table | n <- [0..25]]
            table' = freqs xs

