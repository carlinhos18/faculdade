% Colors and board
colors([green, yellow, blue, orange, white, black]).

board(Board) :-
    colors(Colors),
    permutation_list(Colors, Board).

% --- Permutation implementation (no library needed) ---
permutation_list([], []).
permutation_list(List, [H|Perm]) :-
    select(H, List, Rest),
    permutation_list(Rest, Perm).

% --- Helper predicates ---
consecutive(X, Y, Board) :- append(_, [X,Y|_], Board).

% --- Constraints ---
anywhere(_, _).

next_to(X,X,_).
next_to(X,Y,Board) :- consecutive(X,Y,Board).
next_to(X,Y,Board) :- consecutive(Y,X,Board).

one_space(X,X,_).
one_space(X,Y,Board) :- append(_, [X,_,Y|_], Board).
one_space(X,Y,Board) :- append(_, [Y,_,X|_], Board).

across(X,X,_).
across(X,Y,[A,B,_,D,E,F]) :- member(X,[A,B]), member(Y,[D,E,F]).
across(X,Y,[A,B,_,D,E,F]) :- member(Y,[A,B]), member(X,[D,E,F]).

same_edge(X,X,_).
same_edge(X,Y,[A,B,_,_,_,_]) :- member(X,[A,B]), member(Y,[A,B]).
same_edge(X,Y,[_,_,_,D,E,F]) :- member(X,[D,E,F]), member(Y,[D,E,F]).

position(X, _, Board) :- \+ member(X, Board), !, fail.
position(X, L, Board) :-
    nth1(Pos, Board, X),
    member(Pos, L).

% --- Apply a list of constraints ---
satisfy_constraints([], _).
satisfy_constraints([C|Cs], Board) :-
    call(C, Board),
    satisfy_constraints(Cs, Board).

% --- Solve predicate ---
solve(Constraints, Board) :-
    board(Board),
    satisfy_constraints(Constraints, Board).

% --- Count satisfied constraints ---
count_satisfied([], _, 0).
count_satisfied([C|Cs], Board, N) :-
    call(C, Board),
    count_satisfied(Cs, Board, N1),
    N is N1 + 1.
count_satisfied([C|Cs], Board, N) :-
    \+ call(C, Board),
    count_satisfied(Cs, Board, N).

% --- Max of a list (plain Prolog, no library) ---
max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, MaxT),
    ( H > MaxT -> Max = H ; Max = MaxT ).

% --- Best score ---
best_score(Constraints, Score) :-
    findall(S,
        ( board(Board), count_satisfied(Constraints, Board, S) ),
        Scores),
    max_list(Scores, Max),
    length(Constraints, Total),
    Score is Max - Total.

% --- Example puzzles ---
example(1, [
    next_to(white,orange),
    next_to(black,black),
    across(yellow,orange),
    next_to(green,yellow),
    position(blue,[1,2,6]),
    across(yellow,blue)
]).

example(2, [
    across(white,yellow),
    position(black,[1,4]),
    position(yellow,[1,5]),
    next_to(green,blue),
    same_edge(blue,yellow),
    one_space(orange,black)
]).

example(3, [
    across(white,yellow),
    position(black,[1,4]),
    position(yellow,[1,5]),
    same_edge(green,black),
    same_edge(blue,yellow),
    one_space(orange,black)
]).

example(4, [
    position(yellow,[1,5]),
    one_space(orange,black),
    same_edge(green,black),
    same_edge(blue,yellow),
    position(black,[1,4]),
    across(white,yellow)
]).
