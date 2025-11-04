import Data.Char 
import Test.QuickCheck


calcPi1 :: Int -> Double
calcPi1 n =
  4 * sum (take n (zipWith (/) signs denominators))
  where
    signs = cycle [1, -1]
    denominators = [fromIntegral (2*k + 1) | k <- [0..]]

calcPi2 :: Int -> Double
calcPi2 a = 
    3 + 4 * sum(take a (zipWith(/) signs denominators))
    where 
        signs = cycle[1, -1]
        denominators = [fromIntegral((2*k+2) * (2*k+3) * (2*k+4)) | k <- [0..]]


primes :: [Integer]
primes = sieve [2..]
    where
    sieve (x:xs) = x : sieve[a | a <- xs, a `mod` x /= 0]



twinPrimes :: [(Integer,Integer)]
twinPrimes =filter(\(a,b) -> a == b - 2) $ zip primes(tail primes)




hamming :: [Integer]
hamming = [2^i * 3^j * 5^k | n <- [0..], i <- [0..n], j <- [0..(n-i)], let k = n - i - j]


merge :: [Integer] -> [Integer] -> [Integer]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
    | x < y  = x : merge xs (y:ys)
    | x > y = y : merge (x:xs) ys
    | otherwise = x : merge xs ys


hamming2 :: [Integer]
hamming2 = 1 : merge (map (2*) hamming)
                    (merge (map (3*) hamming)
                            (map(5*) hamming))

rot13 :: String -> String
rot13 [] = []
rot13 (x:xs) = chr (ord x + 13) : rot13 xs



prop_roundtrip :: String -> Property
prop_roundtrip xs = 
        rot13(rot13 xs) === xs


fillWords :: Int -> [AWord] -> Paragraph
fillWords _ [] = []
fillWords maxWidth (w:ws) = go [w] ws
  where
    go current [] = [current] 
    go current (x:xs)
      | lineLength (current ++ [x]) <= maxWidth = go (current ++ [x]) xs
      | otherwise = current : go [x] xs

lineLength :: Line -> Int
lineLength [] = 0
lineLength ws = sum (map length ws) + length ws - 1