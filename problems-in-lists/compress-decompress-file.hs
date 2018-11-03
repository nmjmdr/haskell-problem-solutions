import Data.Map (Map)
import qualified Data.Map as Map
import System.Environment
import System.IO

compress :: [String] -> (Map String Int, [Int])
compress [] = (Map.empty, [])
compress xs = let (m,r,_) = foldl (\(m, acc, c) x -> case (Map.lookup x m) of
                                                      (Just v) -> (m, acc ++ [v], c)
                                                      Nothing -> ( (Map.insert x (c+1) m), acc ++ [c+1], (c+1)) 
                                  ) (Map.empty, [], 0) xs in (m,r)


flipMap :: Ord a => Map k a -> Map a k
flipMap m = Map.fromList (map (\(a,b) -> (b, a)) (Map.toList m)) 


decompress :: [Int] -> Map String Int -> [String]
decompress [] _ = []
decompress vs m = let flipped = flipMap m in map (\v -> case (Map.lookup v flipped) of
                                                         (Just x) -> x
                                                         Nothing -> ['?'] 
                                                 ) vs


compressText :: String -> (Map String Int, [Int])
compressText = compress . words

serializeMap :: Map String Int -> String
serializeMap m = tail (Map.foldrWithKey (\k v acc -> acc ++ "," ++ (show v ++ ":" ++ k)) [] m)

serializeArr :: Show a => [a] -> String
serializeArr xs = tail (foldl (\acc x -> acc ++ "," ++ show x) [] xs)

showCompressed :: (Map String Int, [Int]) -> String
showCompressed (m,is) = unlines [(serializeMap m) , (serializeArr is)]

splitparts :: String -> Char -> String -> [String] -> [String]
splitparts [] _ part acc = acc ++ [part] 
splitparts (x:xs) c part acc = if x == c
                                then acc ++ [part] ++ splitparts xs c [] []
                                else splitparts xs c (part ++ [x]) acc
  

split :: String -> Char -> [String]
split [] _ = []
split xs c = splitparts xs c [] []

type Filename = String

compressFile :: Filename -> IO String
compressFile filename = (readFile filename) >>= return . words >>= return . showCompressed . compress

deserializeMap :: String -> Map String String
deserializeMap xs = foldl (\m x -> let [k,v] = (split x ':') in Map.insert k v m 
                          ) Map.empty (split xs ',')

deserializeArr :: String -> [String]
deserializeArr xs = split xs ','

parseDecompressed :: String -> (Map String String, [String])
parseDecompressed xs = if length lns == 0 
                        then (Map.empty, [])
                        else
                         (deserializeMap (head lns), deserializeArr (head (tail lns)))
                       where lns = lines xs

 
decompressFile :: Filename -> IO String
decompressFile filename = (readFile filename) >>= return . decode .parseDecompressed 

decode :: (Map String String, [String]) -> String
decode (m,xs) = tail (foldl (\acc x -> acc  ++ " " ++ case (Map.lookup x m) of 
                                                       (Just v) -> v
                                                       Nothing -> "?"
                      ) [] xs)



data Command = Compress Filename | Decompress Filename | Err deriving Show

parseArgs :: [String] -> Command
parseArgs (x:xs) = case x of
                    "-c" -> Compress (head xs)
                    "-d" -> Decompress (head xs)
                    otherwise -> Err



main = do
        args <- getArgs
        command <- return (parseArgs args)
        out <- case command of
                (Compress filename) -> compressFile filename 
        print out




  
