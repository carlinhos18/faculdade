    import Data.List (sortBy)



    data List a = Empty | Cons a (List a)


    toList :: [a] -> List a
    toList [] = Empty
    toList (x:xs) = Cons x (toList xs)

    fromList :: List a -> [a]
    fromList Empty = []
    fromList (Cons x xs) = x : fromList(xs)

    data Naipe = Clubs | Spades | Hearts | Diamonds
        deriving (Show, Eq, Ord)

    data Rank = R1 | R2 | R3 | R4 | R5 | R6 | R7 | R8 | R9 | R10 | J | Q | K | A
        deriving (Show, Eq, Ord)

    data Card = Card Naipe Rank
        deriving Show
                
    allCards :: [Card]
    allCards = [Card n r | n <- [Clubs, Spades, Hearts, Diamonds] , r <- [R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, J, Q, K, A]]


    cmp1 :: Card -> Card -> Ordering
    cmp1 (Card n1 r1) (Card n2 r2) =
        case compare r1 r2 of
            EQ -> compare n1 n2
            ord -> ord

    cmp2 :: Card -> Card -> Ordering
    cmp2 (Card n1 r1) (Card n2 r2) =
        case compare r1 r2 of
            EQ -> compare n1 n2 
            ord -> ord






