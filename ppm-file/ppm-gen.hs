import qualified Data.Map as Map

data Color = Red | Blue | Green | Yellow | Orange | Purple | Brown | Black | White deriving Show
data Code = Code Int Int Int deriving Show

-- can come from a file later
pallet :: Color -> Code
pallet Red  = Code 255 0 0 
pallet Blue = Code 0 0 255
pallet Green = Code 0 255 0
pallet Yellow = Code 255 255 0
pallet Orange = Code 255 165 0
pallet Purple = Code 128 0 128
pallet Brown = Code 165 42 42
pallet Black = Code 0 0 0
pallet White = Code 255 255 255 

maxWidth :: [[a]] -> Int
maxWidth xs = foldl (\acc x -> let lenx = length x in if acc < lenx 
                                                     then lenx
                                                     else acc
                  ) 0 xs 
 

repeatEach :: Int -> [a] -> [a]
repeatEach n [] = []
repeatEach n (x:xs) = take n (repeat x) ++ repeatEach n xs

pad :: Int -> [Color] -> [Color]
pad n xs = xs ++ take (n - length xs) (repeat White)

gen :: [[Color]] -> Int -> [[Color]]
gen rows pxSz = foldl (\acc row -> acc ++ take pxSz (repeat (repeatEach pxSz (pad width row)))) [] rows
                 where width = maxWidth rows

toCodeString :: [Color] -> [Int]
toCodeString [] = []
toCodeString (x:xs) = (let (Code r g b) = pallet x in [r,g,b]) ++ toCodeString xs
 

toPPM :: [[Color]] -> String
toPPM [] = unlines ["P3","0 0","255"]
toPPM colors = unlines ["P3",show (length colors) ++ " " ++ show (length (head colors)),"255"] ++ unlines (foldl (\acc row -> acc ++ [unspace (toCodeString row)]) [] colors)

unspace :: (Show a) => [a] -> String
unspace arr = tail (foldl (\acc x -> acc ++ " " ++ show x) [] arr) 

save :: String -> String -> IO ()
save filepath xs = writeFile filepath xs

ppm :: [[Color]] -> Int -> String -> IO()
ppm colors pxSz filepath = save filepath (toPPM (gen colors pxSz))
 
