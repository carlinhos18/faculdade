classify :: Int -> String
classify a | a <= 9 = "failed"
        | 20 <= a = "excellent"
        | 19 <= a = "excellent"
        | 18 <= a =  "very good"
        | 16 <= a = "very good" 
        | 15 <= a = "good"
        | 13 <= a = "good"
        | 12 <= a = "passed"
        | 10 <= a = "passed"

classifyBMI :: Float -> Float -> String
classifyBMI a b | 30 <= bmi =  "obese"
                | 30 < bmi = "overweight"
                | 25 <= bmi = "overweight"
                | 25 < bmi = "normal weight"
                | 18.5 <= bmi = "normal weight"
                | 18.5 < bmi = "underweight"   
        where bmi = a / (b*b)

max3, min3 :: Ord a => a -> a -> a -> a
max3 x y z = max x (max y z)
min3 x y z = min x (min y z)


xordif :: Bool -> Bool -> Bool
xordif a b | a == b = False
           | otherwise = True

short1 :: [a] -> Bool
short1 a | tam < 3 = True
        | otherwise = False
        where tam = length a

short2 :: [a] -> Bool
short2 [] = True
short2 [_] = True
short2 [_,_] = True
short2 (_:_:_:_) = False

median :: Ord a => a -> a -> a -> a
median a b c = max (min a b) (min (max a b) c)

median2 :: (Ord a, Num a) => a -> a -> a -> a
median2 a b c = (a + b + c) - (max(max a b) c + min(min a b) c)

propDivs :: Integer -> [Integer] 
propDivs b = [a | a <-[1..b-1], b `mod` a == 0]


perfects :: Integer -> [Integer]
perfects b = [a | a <- [1..b], sum(propDivs a) == a]

pyths :: Integer -> [(Integer,Integer,Integer)]
pyths a = [(x,y,z) | x <- [1..a-2], y <- [2..a-1], z <- [3..a], x*x + y*y == z*z]

isPrime :: Integer -> Bool
isPrime a
    | a < 2 = True
    | tam == 2  = True
    | otherwise = False
  where
    tam = length [b | b <- [1..floor (sqrt (fromIntegral a))], a `mod` b == 0]

factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial (n - 1)

binom :: Integer -> Integer -> Integer
binom n k = div (factorial n)  (factorial k * factorial (n - k))


pascal :: Integer -> [[Integer]]
pascal n = [[binom x y | y <- [0..x]] | x <- [0..n]]