factorial(0, 1).
factorial(N, F) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

sum_rec(0, 0).
sum_rec(N, Sum) :-
    N > 0,
    N1 is N - 1,
    sum_rec(N1, F1),
    Sum is N + F1.


pow_rec(X, 0, 1).
pow_rec(X, Y, P):-
    Y > 0,
    Y1 is Y - 1,
    pow_rec(X, Y1, P1),
    P is X*P1.


square_rec(N, S) :-
    square_acc(N, N, 0, S).


square_acc(_, 0, Acc, Acc).

square_acc(N, Count, Acc, S) :-
    Count > 0,
    NewAcc is Acc + N,
    NewCount is Count - 1,
    square_acc(N, NewCount, NewAcc, S).

