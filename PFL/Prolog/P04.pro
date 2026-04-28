s(1).
s(2):- !.
s(3).

data(one).
data(two).
data(three).
cut_test_a(X):- data(X).
cut_test_a('five').
cut_test_b(X):- data(X), !.
cut_test_b('five').
cut_test_c(X, Y):- data(X), !, data(Y).
cut_test_c('five', 'five').



print_n(0, _) :- !.
print_n(N, S) :-
    N > 0,
    write(S),
    N1 is N - 1,
    print_n(N1, S).


print_text(Text, Symbol, Padding) :-
    write(Symbol),
    print_n(Padding, ' '),
    write(Text),
    print_n(Padding, ' '),
    write(Symbol),
    nl.


