import System.Win32 (xBUTTON1)
import Control.Arrow (ArrowLoop(loop))
myand :: [Bool] -> Bool
myand [] = True
myand(x:xs) = x && myand xs

myor :: [Bool] -> Bool
myor [] = True
myor(x:xs) = x || myor xs

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat(x:xs) = x ++ myconcat xs

myreplicate :: Int -> a -> [a]
myreplicate 0 _ = []
myreplicate n x = x : myreplicate(n-1)x

myind :: [a] -> Int -> a
myind(x:_) 0 = x
myind(_:xs) n = myind xs (n-1)

myElem :: Eq a => a -> [a] -> Bool
myElem _ [] = False                  
myElem y (x:xs)
    | y == x    = True               
    | otherwise = myElem y xs


leastDiv :: Integer -> Integer
leastDiv n = loop 2
  where
    loop i
      | i * i > n      = n          
      | n `mod` i == 0 = i          
      | otherwise      = loop (i+1)

isPrimeFast :: Integer -> Bool
isPrimeFast a | a > 1 && leastDiv a == a = True
              | otherwise = False

nub :: Eq a => [a] -> [a]
nub [] = []
nub (x:xs) =  x: nub(filter (/=x) xs)

myinter:: a -> [a] -> [a]
myinter _ [] = []
myinter _ [a] = [a]
myinter sep (x:y:xs) = x: sep: myinter sep(y:xs)

myinsert :: Ord a => a -> [a] -> [a]
myinsert y [] = [y]
myinsert y (x:xs)
        | y > x = x: myinsert y xs
        |otherwise = y:x:xs

myisort :: Ord a => [a] -> [a]
myisort [] = []
myisort (x:xs) = myinsert x (myisort xs)


msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort left) (msort right)
  where
    mid = length xs `div` 2
    left = take mid xs
    right = drop mid xs

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys


toBits :: Int -> [Int]
toBits 0 = [0] 
toBits a = reverse(one_zero a)


one_zero :: Int -> [Int]
one_zero 0 = []
one_zero a = a `mod` 2 : one_zero(a`div`2)
                                                                                                                                                                                                                                            

fromBits :: [Int] -> Int
fromBits [] = 0
fromBits (x:xs) = x * 2 ^ length xs + fromBits xs
