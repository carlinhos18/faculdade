import GHC.Float (sqrtFloat)
leftHalf :: [a] -> [a]
leftHalf x = take ( div (length x ) 2) x

rightHalf :: [b] -> [b]
rightHalf z = drop ( div (length z) 2) z

second :: [a] -> a
second a = head (drop 1 a)

ultimo :: [a] -> a
ultimo a = head (drop (length a - 1) a)

init :: [a] -> [a]
init a = take (length a - 1) a

middle :: [a] -> a
middle a = last ( take ( div (length a + 1) 2) a)

checkPalindrome :: String -> Bool
checkPalindrome a = (a == reverse (a))

triangleArea :: Float -> Float -> Float -> Float
triangleArea a b c = sqrtFloat(s*(s-a)*(s-b)*(s-c))
        where s = (a+b+c) / 2