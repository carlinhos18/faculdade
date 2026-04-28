import Data.Char (isUpper, isDigit, isLower)

testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c
    | a < b + c = True
    | b < a + c = True
    | c < a + b = True
    | otherwise = False


areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt(s * ((s-a)* (s-b)*(s-c)))
                    where s =  (a+b+c) / 2


binom :: Integer -> Integer -> Integer
binom a b = product [a-b+1 .. a] `div` product [1..b]


mediana :: Int -> Int -> Int -> Int
mediana a b c = (a+b+c) - maximum [a,b,c] - minimum [a,b,c]

xor :: Bool -> Bool -> Bool
xor True True = False
xor True _ = True
xor _ True = True
xor _ _ = False

max3 :: Int -> Int -> Int -> Int
max3 a b c = maximum[a,b,c]


classifica :: Float -> Float -> String
classifica a b
    | imc < 18.5 = "baixo peso"
    | imc < 25 = "peso normal"
    | imc < 30 = "excesso de peso"
    | otherwise = "obesidade"
    where imc = a / (b*b)


intersperse :: a -> [a] -> [a]
intersperse _ [] = []
intersperse _ [a] = [a]
intersperse b (x:xs) = x : b : intersperse b xs

forte :: String -> Bool
forte x = length x >= 8 && any isUpper x && any isDigit x && any isLower x

myor :: [Bool] -> Bool
myor [] = False
myor (x:xs) = x || myor xs

myand :: [Bool] -> Bool
myand [] = True
myand (x:xs) = x && myand xs

pascal :: Integer -> [[Integer]]
pascal n = [[binom x y | y <- [0 .. x]] | x <- [0 .. n]]


divprop :: Integer -> [Integer]
divprop a = [x | x <- [1..div a 2], mod a x == 0]

merge :: Ord a => [a] -> [a] -> [a]
merge [] [] = []
merge x [] = x
merge [] x = x 
merge (x:xs) (y:ys)
    | x > y = y : merge (x:xs) ys
    | y > x = x : merge xs (y:ys)
    |otherwise = x : y : merge xs ys

sort :: Ord a => [a] -> [a]
sort []     = []
sort (x:xs) = ins x (sort xs)
  where
    ins y [] = [y]
    ins y (z:zs)
      | y <= z    = y : z : zs
      | otherwise = z : ins y zs

insert :: Ord a => a -> [a] -> [a]
insert n [] = [n]
insert n (x:xs) 
    | n <= x = n : x : xs
    | otherwise = x : insert n xs

