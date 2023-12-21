import Data.Char

type Bit = Int

bin2int :: [Bit] -> Int
bin2int = foldr (\x y -> x + 2*y) 0

int2bin :: Int -> [Bit]
int2bin 0 = []
int2bin n = n `mod` 2 : int2bin (n `div` 2)

make8 :: [Bit] -> [Bit]
make8 bits = take 8 (bits ++ repeat 0)

addParity :: [Bit] -> [Bit]
addParity bits = bits ++ (if odd (sum bits) then [1] else [0])

checkParity :: [Bit] -> [Bit]
checkParity bits = if odd (sum (init bits)) == (last bits == 1)
                   then init bits
                   else error "Parity error"

encode :: String -> [Bit]
encode = concat . map (addParity . make8 . int2bin . ord)

chop9 :: [Bit] -> [[Bit]]
chop9 [] = []
chop9 bits = take 9 bits : chop9 (drop 9 bits)

decode :: [Bit] -> String
decode = map (chr . bin2int . checkParity) . chop9

transmit :: String -> String
transmit = decode . channel . encode

channel :: [Bit] -> [Bit]
channel = id
