:-use_module(library(lists)).


list_size([], 0).
list_size([_|T], L) :- list_size(T, L1) , L is L1 + 1 .

list_sum([], 0).
list_sum([H|T], SUM) :- list_sum(T, SUM1), SUM is SUM1 + H .

inner_product([], [], 0).
inner_product([H1|T1], [H2|T2], Sum) :- inner_product(T1, T2, Sum1), Sum is Sum1 + H1*H2.

count(_, [], 0).
count(Elem, [H|T], Sum) :- count(Elem, T, Sum1), (H == Elem -> Sum is Sum1 +1 ; Sum = Sum1).

invert([],[]).
invert([H|T], R) :- invert(T, RT), append(RT, [H], R).

del_one(_,[],_).
del_one(Elem,[Elem|T], T) :- ! .
del_one(Elem, [H|T], [H|R]) :- del_one(Elem, T, R).

del_all(_, [], []).
del_all(Elem, [Elem|T], R) :- del_all(Elem, T, R).
del_all(Elem, [H|T], [H|R]) :- H \= Elem, del_all(Elem, T, R).

del_dups([], []).
del_dups([H|T], [H|R]) :- del_all(H, T, T1), del_dups(T1, R).

list_perm(A,B) :- permutation(A,B).

list_append([], L2, L2).
list_append([H|T], L2, [H|T3]) :- append(T, L2, T3).


