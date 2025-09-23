import GHC.StaticPtr (StaticPtrInfo)
leftHalf :: [a] -> [a]
leftHalf x = take( div (length x ) 2) x
rightHalf :: [b] -> [b]
rightHalf z = drop ( div (length z) 2) z
second :: [a] -> a
second a = head (drop 1 a)
last :: [a] -> a
last a = head (drop (length a - 1)a)
init :: [a] -> [a]
init a = take(length a - 1)a
middle :: [a] -> a
middle a = last( take ( div (length a + 1) 2) a)
checkPalindrome :: String -> Bool
checkPalindrome a = if(a == reverse(a)) then True
            else False