import Data.Char

type Bit = Int

bin2int::[Bit]->Int
bin2int = foldr (\x y -> x + 2*y) 0

int2bin::Int->[Bit]
int2bin 0 = []
int2bin x = x `mod` 2 : int2bin ( x `div` 2)

make8::[Bit]->[Bit]
make8 xs = take 8 (xs ++ repeat 0)

parity::[Bit]->Bit
parity bits | (sum [ 1 | x<-bits, x == 1]) `mod` 2 == 0 = 0
            | otherwise = 1 

addParity::[Bit]->[Bit]
addParity bits = bits ++ [(parity bits)]

encode::String->[Bit]
encode = concat.map (addParity.make8.int2bin.ord)

chopx::Int->[Bit]->[[Bit]]
chopx _ [] = []
chopx t xs = take t xs : chopx t (drop t xs)

verify::Int->[Bit]->[Bit]
verify sz bits | parity input == last bits = input
               | otherwise = error "Parity check failed"
               where input = (take sz bits)

decode::[Bit]->String
decode = map (chr.bin2int.(verify 8)) . (chopx 9)


