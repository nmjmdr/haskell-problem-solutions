import Data.Char

type Bit = Int

bin2int::[Bit]->Int
bin2int = foldr (\x y -> x + 2*y) 0

int2bin::Int->[Bit]
int2bin 0 = []
int2bin x = x `mod` 2 : int2bin ( x `div` 2)

make8::[Bit]->[Bit]
make8 xs = take 8 (xs ++ repeat 0)

encode::String->[Bit]
encode = concat.map (make8.int2bin.ord)

chop8::[Bit]->[[Bit]]
chop8 [] = []
chop8 xs = take 8 xs : chop8 (drop 8 xs)

decode::[Bit]->String
decode = map (chr.bin2int) . chop8


