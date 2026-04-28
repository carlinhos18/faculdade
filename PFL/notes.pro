/*
% ============================================================
% EXAM REFERENCE NOTES - PROLOG
% ============================================================

% ============================================================
% LIST PATTERNS
% ============================================================

% Size:
list_size(List, Size) :- list_size(List, 0, Size).
list_size([],Num,Size) :- Size=Num.
list_size([_|Xs],Num,Size):- Num1 is Num+1, list_size(Xs,Num1,Size).

% Sum:
list_sum(List, Sum) :- list_sum(List, 0, Sum).
list_sum([X|Xs], Num, Sum) :- Num1 is Num+X, list_sum(Xs,Num1, Sum).
list_sum([], Num, Sum) :- Sum=Num.

% Invert:
invert([],[]).
invert([H|T], List2) :- invertHelper(T,[H],List2).
invertHelper([],Acc,Acc).
invertHelper([H|T],Acc,List2) :- invertHelper(T,[H|Acc],List2).

% Delete all instances of N:
del_all(_, [], []).
del_all(X, [X|T], R) :- del_all(X, T, R).
del_all(X, [H|T], [H|R]) :- X \= H, del_all(X, T, R).

% Insert at position N
insert_elem(1, List, Elem, [Elem|List]).
insert_elem(I, [X|Xs], Elem, [X|R]) :- I > 1, I1 is I - 1, insert_elem(I1, Xs, Elem, R).

% Delete at position N
delete_elem(1, [X|Xs], X, Xs).
delete_elem(I, [X|Xs], Elem, [X|R]) :- I > 1, I1 is I - 1, delete_elem(I1, Xs, Elem, R).

% Replace at position N
replace([Old|Xs], 1, Old, New, [New|Xs]).
replace([X|Xs], I, Old, New, [X|R]) :- I > 1, I1 is I - 1, replace(Xs, I1, Old, New, R).

% Maximum element in list
max_list([X], X).
max_list([H|T], Max) :-
    max_list(T, M1),
    ( H >= M1 -> Max = H ; Max = M1 ).

% Map (Pred(X,Y)):
map(_, [], []).
map(P, [H|T], [R|RT]) :-
    G =.. [P, H, R],
    call(G),
    map(P, T, RT).

% Filter:
filter(_, [], []).
filter(P, [H|T], [H|R]) :-
    G =.. [P, H],
    call(G),
    filter(P, T, R).
filter(P, [_|T], R) :-
    filter(P, T, R).

% Fold (Pred(AccIn, Elem, AccOut)):
fold(_, Acc, [], Acc).
fold(P, Acc0, [H|T], AccF) :-
    G =.. [P, Acc0, H, Acc1],
    call(G),
    fold(P, Acc1, T, AccF).

% Inner Product - Produto vetorial:
inner_product([], [], 0).
inner_product([X|Xs], [Y|Ys], R) :-
    inner_product(Xs, Ys, R1),
    R is R1 + X*Y.

% Append:
list_append([], L, L).
list_append([H|T], L, [H|R]) :- list_append(T, L, R).

% Member using append once:
list_member(X, L) :- append(_, [X|_], L).

% Last using append once:
list_last(L, X) :- append(_, [X], L).

% Nth using append + length:
list_nth(N, L, X) :- length(Prefix, N1), N is N1 + 1, append(Prefix, [X|_], L).

% Delete one using append twice:
list_del(L, X, R) :- append(Front, [X|Back], L), append(Front, Back, R).

% Before using append twice:
list_before(A, B, L) :- append(_, [A|Rest], L), member(B, Rest).

% Permutation:
perm([], []).
perm([X|Xs], Ys) :- perm(Xs, Zs), insert(X, Zs, Ys).

insert(X, Ys, [X|Ys]).
insert(X, [Y|Ys], [Y|Zs]) :- insert(X, Ys, Zs).

% ============================================================
% RECURSION
% ============================================================

% Factorial:
factorial(0,1).
factorial(N,F) :- N>0, N1 is N-1, factorial(N1,F1), F is N*F1.

% Sum from 1 to N:
sum_rec(0, 0).
sum_rec(N, Sum) :- N > 0, N1 is N - 1, sum_rec(N1, S1), Sum is S1 + N.

% X^Y - Power:
pow_rec(_, 0, 1).
pow_rec(B, N, Result) :- N > 0, N1 is N // 2, pow_rec(B, N1, R), N mod 2 =:= 0, Result is R * R.
pow_rec(B, N, Result) :- N > 0, N1 is N // 2, pow_rec(B, N1, R), N mod 2 =:= 1, Result is R * R * B.

% Fibonacci:
fib(0,0).
fib(1,1).
fib(N,F) :- N>1, N1 is N-1, N2 is N-2, fib(N1,F1), fib(N2,F2), F is F1+F2.

% Greatest common divisor (Euclid):
gcd(X,0,X).
gcd(X,Y,G) :- Y>0, R is X mod Y, gcd(Y,R,G).

% Least common multiple using X*Y/gcd:
lcm(X, Y, M) :- gcd(X, Y, G), M is X * Y // G.

% Count occurrences:
count(_, [], 0).
count(X, [X|T], N) :- count(X,T,N1), N is N1+1.
count(X, [_|T], N) :- count(X,T,N).

% Remove duplicates:
del_dups([], []).
del_dups([H|T], [H|R]) :- \+ member(H,T), del_dups(T,R).
del_dups([H|T], R) :- member(H,T), del_dups(T,R).

% Prime number:
divisible(X, Y) :- 0 is X mod Y, !.
divisible(X, Y) :- X > Y + 1, divisible(X, Y + 1).
isPrime(2) :- !.
isPrime(X) :- X < 2, !, false.
isPrime(X) :- \+ divisible(X, 2).

% ============================================================
% TAIL RECURSION
% ============================================================

% Factorial:
factorial_tr(N, F) :-
    factorial_acc(N, 1, F).

factorial_acc(0, Acc, Acc).
factorial_acc(N, Acc, F) :- N > 0, Acc1 is Acc * N, N1 is N - 1, factorial_acc(N1, Acc1, F).

% Sum from 1 to N:
sum_rec_tr(N, Sum) :-
    sum_acc(N, 0, Sum).

sum_acc(0, Acc, Acc).
sum_acc(N, Acc, Sum) :- N > 0, Acc1 is Acc + N, N1 is N - 1, sum_acc(N1, Acc1, Sum).

% Tail‑recursive Power.
pow_rec_tr(B, N, P) :-
    pow_acc(B, N, 1, P).

pow_acc(_, 0, Acc, Acc).
pow_acc(B, N, Acc, P) :- N > 0, Acc1 is Acc * B, N1 is N - 1, pow_acc(B, N1, Acc1, P).

% Fibonacci
fibonacci_tr(N, F) :-
    fib_acc(N, 0, 1, F).

fib_acc(0, A, _, A).
fib_acc(N, A, B, F) :- N > 0, A1 is B, B1 is A + B, N1 is N - 1, fib_acc(N1, A1, B1, F).

% ============================================================
% GRAPH SEARCH (DFS / BFS)
% ============================================================

% DFS (avoid cycles):
dfs(D,D,_,[]).
dfs(X,D,Vis,[C|R]) :-
    edge(X,N,C),
    \+ member(N,Vis),
    dfs(N,D,[N|Vis],R).

% BFS (queue):
bfs(Start,Goal,Path) :-
    bfs_queue([[Start]], Goal, Path).

bfs_queue([[Goal|Rest]|_], Goal, Path) :-
    reverse([Goal|Rest], Path).

bfs_queue([Path|Others], Goal, Final) :-
    Path = [Node|_],
    findall([Next|Path],
        (edge(Node,Next,_), \+ member(Next,Path)),
        Expansions),
    append(Others, Expansions, NewQueue),
    bfs_queue(NewQueue, Goal, Final).


% ============================================================
% FINDALL / BAGOF / SETOF
% ============================================================

% findall(X, Goal, List) → always returns a list (possibly empty)
% bagof(X, Goal, List)  → fails if no solutions
% setof(X, Goal, List)  → sorted, unique, fails if no solutions
/*
findall(X,Goal,L).                   % recolher
findall(A-B,Goal,L).                 % pares
findall(X,(G1,findall(Y,G2,Ys)),L).  % nested
findall(X,Goal,L0), sort(L0,L).      % únicos
findall(A-B,(G,A@<B),L).             % pares sem duplicados
findall(Term,Goal,L).                % estruturas
findall(Path,search(S,E,Path),L).    % caminhos
*/

% ============================================================
% IO PATTERNS
% ============================================================

% Print N times:
% print_n(0,_).
% print_n(N,S) :- N>0, write(S), N1 is N-1, print_n(N1,S).

% Read number (digit by digit):
% read_number(N) :-
%     read_digits(Codes),
%     number_codes(N, Codes).

% read_digits([C|R]) :-
%     peek_code(C),
%     C \= 10,
%     get_code(C),
%     read_digits(R).
% read_digits([]) :-
%     peek_code(10),
%     get_code(_).

% Read string:
% read_string(S) :-
%     read_digits(S).


% ============================================================
% META‑PROGRAMMING
% ============================================================
% my_functor(T,F,N) :- T =.. [F|Args], length(Args,N).
% my_arg(I,T,A) :- T =.. [_|Args], nth1(I,Args,A).
% univ(T,L) :- T =.. L.

% ============================================================
% TREES
% ============================================================
% tree_size(nil,0).
% tree_size(t(_,L,R),N) :- tree_size(L,NL), tree_size(R,NR), N is NL+NR+1.

% tree_height(nil,0).
% tree_height(t(_,L,R),H) :-
%     tree_height(L,HL), tree_height(R,HR),
%     H is max(HL,HR)+1.
% 
% tree_leaves(nil,0).
% tree_leaves(t(_,nil,nil),1).
% tree_leaves(t(_,L,R),N) :-
%     tree_leaves(L,NL), tree_leaves(R,NR),
%     N is NL+NR.

% tree_map(_,nil,nil).
% tree_map(P,t(X,L,R),t(Y,NL,NR)) :-
%     G=..[P,X,Y], call(G),
%     tree_map(P,L,NL), tree_map(P,R,NR).

% tree_value_at_level(t(X,_,_),X,0).
% tree_value_at_level(t(_,L,R),V,N) :-
%     N>0, N1 is N-1,
%     (tree_value_at_level(L,V,N1) ; tree_value_at_level(R,V,N1)).

% tree_values_at_level(nil,_,[]).
% tree_values_at_level(t(X,_,_),0,[X]).
% tree_values_at_level(t(_,L,R),N,Vals) :-
%    N>0, N1 is N-1,
%    tree_values_at_level(L,N1,VL),
%    tree_values_at_level(R,N1,VR),
%    append(VL,VR,Vals).

% ============================================================
% RUN‑LENGTH ENCODING
% ============================================================

% rle(+List1, ?List2) — run‑length encoding (X-Count pairs)
% rle([], []).
% rle([H|T], [H-N|R]) :-
%     count_run(H, T, N, Rest),
%     rle(Rest, R).

% count_run(+Elem, +List, -Count, -Rest)
% count_run(X, [X|T], N, Rest) :-
%     count_run(X, T, N1, Rest),
%     N is N1 + 1.
% count_run(X, [Y|T], 1, [Y|T]) :- X \= Y.
% count_run(_, [], 1, []).

% un_rle(+List1, ?List2) — decode run‑length encoding
% un_rle([], []).
% un_rle([X-N|T], R) :-
%     replicate(N, X, L1),
%     un_rle(T, L2),
%     list_append(L1, L2, R).

% replicate(+Amount, +Elem, ?List)
% replicate(0, _, []).
% replicate(N, X, [X|R]) :-
%     N > 0,
%     N1 is N - 1,
%     replicate(N1, X, R).


% ============================================================
% LIST SORTING
% ============================================================

% is_ordered(+List)
% is_ordered([]).
% is_ordered([_]).
% is_ordered([A,B|T]) :- A =< B, is_ordered([B|T]).

% insert_ordered(+Value, +List1, ?List2)
% insert_ordered(X, [], [X]).
% insert_ordered(X, [H|T], [X,H|T]) :- X =< H.
% insert_ordered(X, [H|T], [H|R]) :- X > H, insert_ordered(X, T, R).

% insert_sort(+List, ?OrderedList)
% insert_sort([], []).
% insert_sort([H|T], R) :-
%     insert_sort(T, R1),
%     insert_ordered(H, R1, R).


% ============================================================
% PASCAL'S TRIANGLE
% ============================================================

% pascal(+N, ?Lines)
% pascal(1, [[1]]).
% pascal(N, Lines) :-
%     N > 1,
%     N1 is N - 1,
%     pascal(N1, Prev),
%     append(_, [LastLine], Prev),
%     next_pascal_line(LastLine, New),
%     append(Prev, [New], Lines).

% next_pascal_line(+PrevLine, -NextLine)
% next_pascal_line([X|Xs], [X|Ys]) :-
%     next_pascal_line_aux(Xs, X, Ys).

% next_pascal_line_aux([], Last, [Last]).
% next_pascal_line_aux([X|Xs], Prev, [Sum|Ys]) :-
%     Sum is Prev + X,
%     next_pascal_line_aux(Xs, X, Ys).


% ============================================================
% RIPPLE‑CARRY ADDER
% ============================================================

% XOR gate
% xor(0,0,0).
% xor(0,1,1).
% xor(1,0,1).
% xor(1,1,0).

% AND gate
% and(0,_,0).
% and(_,0,0).
% and(1,1,1).

% full_adder(+A,+B,+Cin,?S,?Cout)
% full_adder(A,B,Cin,S,Cout) :-
%    xor(A,B,T1),
%    xor(T1,Cin,S),
%    and(A,B,C1),
%    and(T1,Cin,C2),
%    xor(C1,C2,Cout).

% ripple_adder(+ListA, +ListB, ?Result)
% ripple_adder(A, B, R) :-
%     ripple(A, B, 0, R).

% ripple(+A,+B,+CarryIn,?Result)
% ripple([], [], Cin, [Cin]).
% ripple([A|As], [B|Bs], Cin, [S|R]) :-
%     full_adder(A,B,Cin,S,Cout),
%     ripple(As, Bs, Cout, R).

% ============================================================
% UNIFIABLE
% ============================================================

% unifiable([], _, []).
% unifiable([H|T], Term, [H|R]) :-
%     \+ \+ (H = Term),
%     unifiable(T, Term, R).
% unifiable([_|T], Term, R) :-
%     unifiable(T, Term, R).


% ============================================================
% MISSIONARIES & CANNIBALS
% ============================================================

% state(MLeft, CLeft, BoatSide, MRight, CRight)

% safe(M, C) :- M >= C ; M = 0.

% move(ML,CL,left, MR,CR,right, ML2,CL2, MR2,CR2) :-
%    member((M,C), [(2,0),(0,2),(1,1),(1,0),(0,1)]),
%    ML2 is ML - M, CL2 is CL - C,
%    MR2 is MR + M, CR2 is CR + C,
%    ML2>=0, CL2>=0, safe(ML2,CL2), safe(MR2,CR2).

% move(ML,CL,right, MR,CR,left, ML2,CL2, MR2,CR2) :-
%    member((M,C), [(2,0),(0,2),(1,1),(1,0),(0,1)]),
%    MR2 is MR - M, CR2 is CR - C,
%    ML2 is ML + M, CL2 is CL + C,
%    MR2>=0, CR2>=0, safe(ML2,CL2), safe(MR2,CR2).

% missionaries_and_cannibals(Moves) :-
%    mc_dfs(state(3,3,left,0,0), [], Moves).

% mc_dfs(state(0,0,_,3,3), _, []).
% mc_dfs(state(ML,CL,Side,MR,CR), Vis, [Move|R]) :-
%    move(ML,CL,Side,MR,CR,Side2, ML2,CL2,MR2,CR2),
%    Move = state(ML2,CL2,Side2,MR2,CR2),
%    \+ member(Move, Vis),
%    mc_dfs(Move, [Move|Vis], R).


% ============================================================
% CLIMBING STAIRS
% ============================================================

% steps(N, Count, Ways) :-
%    findall(W, steps_list(N, W), Ways),
%    length(Ways, Count).

% steps_list(0, []).
% steps_list(N, [1|R]) :-
%    N >= 1,
%    N1 is N - 1,
%    steps_list(N1, R).
% steps_list(N, [2|R]) :-
%    N >= 2,
%    N1 is N - 2,
%    steps_list(N1, R).


% ============================================================
% OPERATORS (PATTERNS)
% ============================================================

% Define operator:
% :- op(Precedence, Type, Name).

% Example:
% :- op(500, xfx, na).
% :- op(500, yfx, la).
% :- op(500, xfy, ra).

% ============================================================
% UNIFICATION & LOGIC
% ============================================================
/*
\+ \+ (A = B).        % testar unificação sem bind
\+ Goal.              % negação por falha
G =.. [F|Args].       % construir termo
call(G).              % executar termo
functor(T,F,N).       % extrair functor/arity
arg(I,T,A).           % extrair argumento
*/

% ============================================================
% EXAM EXERCISES PROLOG
% ============================================================
% ÉPOCA ESPECIAL 2024/2025

% by(Character, Movie, Actor)

% 1) plays_twins(?Actor, ?Movie) que sucede se o ator Actor tiver interpretado pelo menos dois personagens
% diferentes no filme/série Movie

% play_twins(Actor, Movie) :-
% by(Char1 , Movie, Actor),
% by(Char2, Movie, Actor),
% Char1 \= Char2.


% 2)  actor_movies(+Actor, -Movies) que devolve em Movies a lista de filmes/séries distintos protagonizados
% por Actor (a ordem dos elementos na lista não é relevante mas a lista não deve conter valores repetidos).

% actor_movies(Actor, L):-
%   actor_movies(Actor, [], L).
% actor_movies(Actor, Acc, L):-
%   by(_Char, Movie, Actor),
%   \+ member(Movie, Acc), !,
%   actor_movies(Actor, [Movie|Acc], L).
% actor_movies(_Actor, Acc, Acc).


% 4) playedBy(+Character, -List), que devolve em List uma lista com todos os atores que representaram a
% personagem Character, contendo uma lista com os respectivos filmes/séries

% playedBy(Character, L) :-
% setof(Actor , Movie^by(Character, Movie, Actor), Actors),
% findall(A-Ms, (member(A, Actors), findall(M, by(Character, M, A), Ms)), List).    


% 5)  most_popular(+Exclude, -List, -NMovies), que devolve em List os nomes dos atores que participaram em
% mais filmes/séries diferentes (esta lista terá mais do que um valor em caso de empate; neste caso a ordem dos elementos não é
% importante), e em NMovies o número de filmes em que entraram

% most_popular(Exclude, List, NMovies):-
%   setof(N-Actor, (_Char,_Movie,_Movies)^(
%                        by(_Char, _Movie, Actor), \+ member(Actor, Exclude),
%                        actor_movies(Actor, _Movies), length(_Movies, N) ), TempL),
% last(TempL, NMovies-_),
% findall(Actor, member(NMovies-Actor, TempL), List).

% 6) connection_link(+Actor1, +Actor2, -ConnectionList), que determina uma ligação possível entre dois
% atores (se essa ligação existir). Caso não exista qualquer ligação entre os dois atores, o predicado deve falhar. Caso exista uma
% ligação, a lista ConnectionList deve ser preenchida com os nomes dos atores e filmes/séries que permitem ligar os dois atores
% Actor1 e Actor2, 

% connection_link(Actor1, Actor2, List):-
%   connection_link(Actor1, Actor2, [Actor1], RList),
%   reverse(RList, List).
% connection_link(Actor1, Actor2, Tmp, [Actor2, Movie | Tmp]):- % ligação direta entre Actor1 e Actor2 via Movie
%   by(_C1, Movie, Actor1),
%   \+ member(Movie, Tmp),
%   by(_C2, Movie, Actor2),
%   Actor1 \= Actor2.
% connection_link(Actor1, Actor2, Tmp, List):- % se não há ligação direta, seguir via outro ator
%   by(_C1, Movie, Actor1),
%   \+ member(Movie, Tmp),
%   by(_C2, Movie, Actor3),
%   Actor1 \= Actor3,
%   \+ member(Actor3, Tmp),
%   connection_link(Actor3, Actor2, [Actor3, Movie | Tmp], List).

% 7) pretty_print(+ConnectionList), que recebe uma lista de atores e filmes/séries no formato gerado pela
% questão anterior, e imprime a informação para a consola no formato que se pode ver no exemplo abaixo
% pretty_print([A, B, C|T]):-
%    write(A), write(' worked in '), write(B), write(' with '), write(C),
%    pretty_print2(T).
% pretty_print2([]):-
%   write('.'), nl.
% pretty_print2([B, C|T]):-
%   write(','), nl, write(' who worked in '), write(B), write(' with '), write(C),
%   pretty_print2(T).

% TESTE 2023/2024 DISHES

% dish(Name, Price, IngredientGrams).
% ingredient(Name, CostPerGram).

% count_ingredients(?Dish, ?NumIngredients), which determines how many different ingredients are needed to produce a dish.
% count_ingredients(D, Num):-
%   dish(D, _ ,  Ing),
%   length(Ing, Num).

% Implement ingredient_amount_cost(?Ingredient, +Grams, ?TotalCost), which determines the total cost (in cents) of buying a certain amount (in grams) of an ingredient
% ingredient_amount_cost(I, Gr, Tc) :- 
%   ingredient(I, C),
%   Tc is C * Gr.

% Implement dish_profit(?Dish, ?Profit), which determines the profit of selling a dish in the restaurant.
% A dish’s profit is the difference between its price and the combined cost of its ingredients.

% profitByDish([],0).
% profitByDish([Ing-Grams | Rest] , TotalCost) :-
%   ingredient_amount_cost(Ing, Grams, Cost),
%   profitByDish(Rest, Aux),
%   TotalCost is Cost + Aux .

% dish_profit(D, P) :-
%   dish(D, PriceDish, List),
%   profitByDish(List, Res),
%   P is PriceDish - Res.

% Implement most_expensive_dish(?Dish, ?Price), which determines the most expensive dish one can eat at the restaurant and its price. In case of a tie, the predicate must return, via backtracking, each of the most expensive dishes.
% most_expensive_dish(D, P) :-
%   dish(D, P, _),
%   \+((
%     dish(_,P2,_),
%     P2 > P
%   )).

% Implement consume_ingredient(+IngredientStocks, +Ingredient, +Grams, ?NewIngredientStocks), which receives a list of ingredient stocks (as
% pairs of Ingredient-Amount), an ingredient, and an amount (in grams) and computes a new list obtained from removing the given amount
% of ingredient from the original stock. The predicate must only succeed if there is enough ingredient in stock.
% Constraint: In this question, and in this question only, you are not allowed to use recursion. Solutions using recursion will only receive up
% to 25% of the maximum score.

% consume_ingredient(Is, Ing, Gr, Res) :-
% select(Ing-Grams, Is, Rest),
%   Grams >= Gr,
%   NewVal is Grams - Gr,
%   Res = [Ing-NewVal | Rest].

% Implement count_dishes_with_ingredient(+Ingredient, ?N), which determines how many dishes use the given ingredient
% count_dishes_with_ingredient(Ing, N) :-
%     findall(
%         Dish,
%         (
%             dish(Dish, _, Ingredients),
%             member(Ing-_, Ingredients)
%         ),
%         Dishes
%     ),
%     length(Dishes, N).


% Implement list_dishes(?DishIngredients), which returns a list of pairs Dish-ListOfIngredients.
% list_dishes(D) :-
%   findall(
%     Dish-IngNames,
%     (
%     dish(Dish,_,Ing),
%     findall(Name, member(Name-_, Ing), IngNames)
%     ),
%     D
%   ).

% Implement most_lucrative_dishes(?Dishes), which returns the restaurant’s dishes, sorted by decreasing amount of profit. In case of a tie, any
% order of the tied dishes will be accepted.

% most_lucrative_dishes(Dishes) :- 
% findall(
%   Dish-Profit,
%   dish_profit(Dish,Profit),
%   LOL
% ),
% keysort(LOL, SortedDishes),
% reverse(SortedDishes, ReversedDishes),
% pairs_values(ReversedDishes, Dishes).



%G1
% edge(g1, br, o).
% G2
% edge(g2, cl, he).

% Implement common_edges(+G1, +G2, ?L), which, given the identifiers of two graphs (G1 and G2), computes their list of common edges
% my_member(X, [X|_]).
% my_member(X, [_|T]) :- my_member(X, T).

% my_intersection([], _, []).
% my_intersection([H|T], L2, [H|R]) :-
%     my_member(H, L2), !,
%     my_intersection(T, L2, R).
% my_intersection([_|T], L2, R) :-
%     my_intersection(T, L2, R).

% calculate_graph(Graph, Edges):-
% findall(
%   Start-Finish,
%   edge(Graph, Start, Finish),
%   Edges
% ).

% common_edges(G1, G2, L) :-
% calculate_graph(G1, E1),
% calculate_graph(G2, E2),
% my_intersection(E1, E2, L).



% TESTE PASSADO

% bird(Name, Species, Gender, Colors)

% 1) male(?Name), which succeeds if the bird called Name is male.
% male(Name):-
%    bird(Name, _, male, _)

% 2) has_more_color_of(?Name, ?GreaterColor, ?LesserColor), which succeeds if bird Name has more of the color GreaterColor than of LesserColor
% (i.e. GreaterColor comes before LesserColor in the bird's color list).

% has_more_color_of(N, C1, C2):-
%    bird(N, _, _, Cs),
%    append(_, [C1|T], Cs),
%    append(_, [C2|_], T).

% 3) most_colorful(?Species, ?Name, ?NColors), which succeeds if Name is the name of the bird with the highest number of colors
% (returned in NColors) of species Species.
% In case of a tie, each bird with the maximum NColors should be returned via backtracking.

% most_colorful(Sp, N, NC):-
%    bird(N, Sp, _, Cs),
%    length(Cs, NC),
%    \+((
%        bird(_, Sp, _, Cs1),
%        length(Cs1, NC1),
%        NC1 > NC
%    )).

% 4) unique_colors(+Species, -ListOfColors),
% which succeeds if ListOfColors is a list without duplicates of all colors found in at least one bird of species Species.

% unique_colors(Sp, L):-
%    unique_colors_aux(Sp, [], L).

% unique_colors_aux(Sp, Acc, Sol):-
%    bird(_, Sp, _, Cs),
%    member(C, Cs),
%    \+ member(C, Acc),
%    !,
%    unique_colors_aux(Sp, [C|Acc], Sol).
% unique_colors_aux(_, Acc, Acc).

% 5) is_color_permutation(?Name1, ?Name2), which succeeds if the colors of two distinct birds Name1 and Name2 are permutations of one another,
% i.e., the lists of colors of Name1 and Name2 have the same values, possibly in a distinct order.

% is_color_permutation(N1, N2) :-
%    bird(N1, _, _, Cs1),
%    bird(N2, _, _, Cs2),
%    N1 \= N2,
%    sort(Cs1, Sorted),
%    sort(Cs2, Sorted).

% 6) dif_n_colors(+Species, ?D), which succeeds if
% D is the difference between the maximum and minimum number of colors among the birds of species Species.

% dif_n_colors(Sp, D):-
%    findall(N, ( bird(_, Sp, _, Cs), length(Cs, N) ), L),
%    sort(L, Sorted),
%    last(Sorted, Max),
%    Sorted = [Min|_],
%    D is Max - Min.

% 7)  most_common_color_per_species(?Species, ?Color), which succeeds if Color is the most common color among all birds of species Species.

% most_common_color_per_species(Sp, Color):-
%   bagof(C, (N,G,Cs)^( bird(N, Sp, G, Cs), member(C, Cs) ), Colors),
%    setof(
%        N-C,(Rest,All,LRest)^
%            ( member(C, Colors),
%            delete(Colors, C, Rest),
%            length(Colors, All),
%            length(Rest, LRest),
%            N is All-LRest ),
%    Counts),
%    last(Counts, MaxN-_),
%	member(MaxN-Color, Counts).

% colorful_routes(+Ni, +Nf, ?L) which succeeds if L is a 'colorful route' between bird Ni and bird Nf (identified by their names).
% A 'colorful route' is an ordered sequence of bird names starting at Ni and ending at Nf, where:
% a - No bird appears more than once in the route;
% b - At least 5 birds are visited, including Ni and Nf;
% c - Each pair of consecutive birds have two distinct main colors
% (i.e. the heads of the color list of two adjacent birds are different,
% so after visiting a bird that is mainly blue, the next bird cannot be mainly blue, but it can still have some blue feathers).

% colorful_routes(Ni, Nf, L):-
%    L = [_, _, _, _, _ | _],
%    dfs([Ni], Nf, L).

% dfs([Nf|_], Nf, [Nf]).
% dfs([Na|Acc], Nf, [Na|Path]):-
%    bird(Na, _, _, [Ca|_]),
%    bird(Nb, _, _, [Cb|_]),
%    Ca \= Cb,
%    \+ member(Nb, Acc),
%    dfs([Nb,Na|Acc], Nf, Path).

% ============================================================
% EXAM REFERENCE NOTES — HASKELL 
% ============================================================

% ============================================================
% LIST PATTERNS
% ============================================================

% Map
% map :: (a -> b) -> [a] -> [b]
% map _ []     = []
% map f (h:t)  = f h : map f t

% Filter
% filter :: (a -> Bool) -> [a] -> [a]
% filter _ [] = []
% filter p (h:t)
%   | p h       = h : filter p t
%   | otherwise = filter p t

% Fold (left)
% foldl :: (b -> a -> b) -> b -> [a] -> b
% foldl _ acc []     = acc
% foldl f acc (h:t)  = foldl f (f acc h) t

% Fold (right)
% foldr :: (a -> b -> b) -> b -> [a] -> b
% foldr _ acc []     = acc
% foldr f acc (h:t)  = f h (foldr f acc t)

% Append
% (++)
% [] ++ l     = l
% (h:t) ++ l  = h : (t ++ l)

% Member
% elem :: Eq a => a -> [a] -> Bool
% elem _ [] = False
% elem x (h:t) = x == h || elem x t

% Last
% last :: [a] -> a
% last [x]   = x
% last (_:t) = last t

% Nth element (1-based)
% nth :: Int -> [a] -> a
% nth 1 (x:_) = x
% nth n (_:t) = nth (n-1) t

% Delete one occurrence
% delete :: Eq a => a -> [a] -> [a]
% delete _ [] = []
% delete x (h:t)
%   | x == h    = t
%   | otherwise = h : delete x t

% Before (A before B)
% before :: Eq a => a -> a -> [a] -> Bool
% before a b xs =
%   case dropWhile (/= a) xs of
%     []     -> False
%     (_:r)  -> b `elem` r

% Permutations
% perm :: [a] -> [[a]]
% perm [] = [[]]
% perm (x:xs) =
%   [ zs | ys <- perm xs, zs <- insert x ys ]

% insert :: a -> [a] -> [[a]]
% insert x []     = [[x]]
% insert x (y:ys) =
%   (x:y:ys) : map (y:) (insert x ys)


% ============================================================
% RECURSION
% ============================================================

% Factorial
% fact :: Int -> Int
% fact 0 = 1
% fact n = n * fact (n-1)

% Fibonacci
% fib :: Int -> Int
% fib 0 = 0
% fib 1 = 1
% fib n = fib (n-1) + fib (n-2)

% GCD (Euclid)
% gcd :: Int -> Int -> Int
% gcd x 0 = x
% gcd x y = gcd y (x `mod` y)

% Count occurrences
% count :: Eq a => a -> [a] -> Int
% count _ [] = 0
% count x (h:t)
%   | x == h    = 1 + count x t
%   | otherwise = count x t

% Remove duplicates
% nub :: Eq a => [a] -> [a]
% nub [] = []
% nub (h:t)
%   | h `elem` t = nub t
%   | otherwise  = h : nub t


% ============================================================
% GRAPH SEARCH (DFS / BFS)
% ============================================================

% Graph as adjacency function
% type Graph a = a -> [a]

% DFS (avoid cycles)
% dfs :: Eq a => Graph a -> a -> a -> [a] -> Bool
% dfs _ cur goal _ | cur == goal = True
% dfs g cur goal visited =
%   any (\n -> dfs g n goal (n:visited))
%       [ n | n <- g cur, n `notElem` visited ]

% BFS (queue of paths)
% bfs :: Eq a => Graph a -> a -> a -> Maybe [a]
% bfs g start goal = bfsQueue [[start]]
%   where
%     bfsQueue [] = Nothing
%     bfsQueue (path@(x:_):qs)
%       | x == goal = Just (reverse path)
%       | otherwise =
%           bfsQueue (qs ++
%             [ n:path | n <- g x, n `notElem` path ])


% ============================================================
% FINDALL / BAGOF / SETOF (HASKELL VIEW)
% ============================================================


% Haskell findall
% [ x | x <- domain, goal x ]

% Unique results
% unique :: Ord a => [a] -> [a]
% unique = map head . group . sort

% Pairs
% pairs :: [a] -> [b] -> [(a,b)]
% pairs xs ys = [ (x,y) | x <- xs, y <- ys ]


% ============================================================
% IO PATTERNS
% ============================================================

% Print N times
% printN :: Int -> String -> IO ()
% printN 0 _ = return ()
% printN n s = putStr s >> printN (n-1) s

% Read number
% readNumber :: IO Int
% readNumber = readLn

% Read string
% readString :: IO String
% readString = getLine


% ============================================================
% META-PROGRAMMING (CONCEPTUAL)
% ============================================================

% Prolog (=..) / call
% Haskell: functions are values

% apply :: (a -> b) -> a -> b
% apply f x = f x


% ============================================================
% TREES
% ============================================================

% data Tree a
%   = Nil
%   | T a (Tree a) (Tree a)

% treeSize :: Tree a -> Int
% treeSize Nil = 0
% treeSize (T _ l r) =
%   1 + treeSize l + treeSize r

% treeHeight :: Tree a -> Int
% treeHeight Nil = 0
% treeHeight (T _ l r) =
%   1 + max (treeHeight l) (treeHeight r)

% treeLeaves :: Tree a -> Int
% treeLeaves Nil = 0
% treeLeaves (T _ Nil Nil) = 1
% treeLeaves (T _ l r) =
%   treeLeaves l + treeLeaves r

% treeMap :: (a -> b) -> Tree a -> Tree b
% treeMap _ Nil = Nil
% treeMap f (T x l r) =
%   T (f x) (treeMap f l) (treeMap f r)

% values at level
% treeValuesAtLevel :: Tree a -> Int -> [a]
% treeValuesAtLevel Nil _ = []
% treeValuesAtLevel (T x _ _) 0 = [x]
% treeValuesAtLevel (T _ l r) n =
%   treeValuesAtLevel l (n-1) ++
%   treeValuesAtLevel r (n-1)

% ============================================================
% EXAM EXERCISES HASKELL
% ============================================================

% ÉPOCA ESPECIAL 2024/2025

% type Movie = (String, [String])
% Exemplo: 
% myMovies :: [Movie]
% myMovies = [("Titanic", ["Kate Winslet","Leonardo DiCaprio"]), ("Revolutionary Road",["Kate Winslet","Leonardo DiCaprio"]),
% ("Elektra ",["Jennifer Garner"]), ("The Great Gatsby",["Leonardo DiCaprio"])]

% 1) findActors :: [Movie] -> String -> Maybe [String], que recebe uma lista de filmes 'movies' e o título de um filme
%    'title', e devolve a lista dos atores correspondente ao filme com título 'title' em 'movies'.

% findActors :: [Movie] -> String -> Maybe [String]
% findActors [] _ = Nothing
% findActors ((x, y):xs) movie
%   | x == movie = Just y
%   | otherwise findActors xs movie


% 2) moviesWithActor :: [Movie] -> String -> [Movie], que  recebe uma lista de filmes 'movies' e o nome de um ator
% 'actor', e devolve a sublista de 'movies' dos filmes em que 'actor' participou.
% moviesWithActor :: [Movie] -> String -> [Movie]
% moviesWithActor _ [] = []
% moviesWithActor ((x,y):xs) movie
%   | actor `elem` y = (x,y) : moviesWithActor xs actor
%   | otherwise = moviesWithActor xs movie
% OU ENTÃO
% moviesWithActor movies actor =
%   filter (\(_, actors) -> actor `elem` actors) movies

% 3) uniqueActors :: [Movie] -> [String], que devolve uma lista com todos os atores da lista de filmes 'movies', sem
% repetidos

% uniqueActors :: [Movie] -> [String]
% uniqueActors [] = []
% uniqueActors movie = uniqueVals(auxActors movie)
%
% auxActors [Movie] -> [String]
% auxActors [] = []
% auxActors ((_,y):xs) = y ++ auxActors xs
%
% uniqueVals [String] -> [String]
% uniqueVals [] -> []
% uniqueVals (x:xs) =
%   | x `elem` xs = uniqueVals xs
%   | otherwise = x : uniqueVals xs

% 4) actorFrequencies :: [Movie] -> [(String, Int)], que devolve uma lista de pares '(nome de ator, numero de filmes
% em que participa)' da lista de filmes 'movies' 

% actorFrequencies :: [Movie] -> [(String, Int)]
% actorFrequencies [] = []
% actorFrequencies movie = auxFrequencies (auxActors movie)

% auxFrequencies [String] -> [(String, Int)]
% auxFrequencies (x:xs) =  
%   let n = count x (x:xs)
%       rest = removeAll x xs
%   in (x, n) : auxFrequencies rest

% removeAll :: String -> [String] -> [String]
% removeAll _ [] = []
% removeAll x (y:ys)
%   | x == y    = removeAll x ys
%   | otherwise = y : removeAll x ys

% 7) Considere a seguinte função funcX:
% funcX = foldl (\acc _ -> pred acc) 0
% Reimplemente esta função usando a técnica que preferir e SEM usar funções da família dos folds (foldr, foldl, foldr1, scanr, ...).

% funcXRec :: [a] -> Int
% funcXRec [] = 0
% funcXRec (_:xs) = pred (funcXRec xs)

% 8) evenPos, que dadas duas listas xs e ys (com tamanhos que podem ser diferentes) retorna a
% lista de pares de elementos que aparecem nas mesmas posições pares das listas, mas apenas se estes tiverem valores diferentes.

% evenPos Eq a => [a] -> [a] -> [(a,a)]
% evenPos _ [] = []
% evenPos [] _ = []
% evenPos (x:_:xs) (y:_:ys) = 
%   | x == y = evenPos xs ys
%   | otherwise = (x,y) : evenPos xs ys


% 9) Considere a seguinte série definida recursivamente da seguinte forma:
% a_0 = 0
% a_1 = 1
% a_n = (3 ∗ a_(n−1)) − 2 ∗ a_(n−2) if n > 1
% Defina a lista infinita list contendo todos os termos da série:
% list :: [Integer]
% list = 0 : 1 : zipWith(\x y -> 3*y - 2*x) list (tail list)

% 10) Considere a seguinte definição de um tipo recursivo para representar expressões em lógica proposicional:
% data Prop = Const Bool -- constantes
% | Neg Prop -- negação de uma sub-expressão
% | Conj Prop Prop -- conjunção de duas sub-expressões
% | Disj Prop Prop -- disjunção de duas sub-expressões
% | Impl Prop Prop -- implicação de duas sub-expressões

% valor :: Prop -> Bool
% valor (Const b)       = b
% valor (Neg p)         = not (valor p)
% valor (Conj p1 p2)    = valor p1 && valor p2
% valor (Disj p1 p2)    = valor p1 || valor p2
% valor (Impl p1 p2)    = not (valor p1) || valor p2

% TESTE 2026

% type Node = String   -- some city
% type Dist = Int      -- some distance
% type Edges = [(Node,Node,Dist)] -- directed connections

% inverse :: Edges -> Edges that reverses the edges, maintaining the distances. Keep the edge order of the input list.
% inverse :: Edges -> Edges
% inverse ((a,b,c):xs) = [(b,a,c) | (a,b,c) <- xs]

% newEdges :: Edges -> Edges, that composes pairs of edges:
% if there is an edge (a,b) with distance d and another (b,c) with distance d', then there will be new edge (a,c) with distance d+d';
% exception: don't add edges (a,a) from a node to itself.

% newEdges :: Edges -> Edges
% newEdges edges = [(x,z,d+d') | (x,y,d)<-edges, (y',z,d')<-edges, y'== y && x/=z]

% pathDistance :: Edges -> [Node] -> Maybe Dist that takes a list of edges and a list of nodes
% and computes the total distance of a path made up of the nodes in sequence
% (or Nothing if any of the connections in the path does not occur in the edges).

% pathDistance :: Edges -> [Node] -> Maybe Dist
% pathDistance edges [] = Just 0
% pathDistance edges (start:path) = aux start 0 path
%   where
%     aux v acc [] = Just acc
%     aux v acc (u:path) =
%       case [d | (x,y,d)<-edges, x==v && y==u] of
%         (d:_) -> aux u (acc+d) path
%         [] -> Nothing

% nubBy :: (a -> a -> Bool) -> [a] -> [a], that removes duplicate values from a list using the supplied argument function to check for equality.
% In particular, the usual nub function is the same as nubBy (==).
% For each value that appears multiple times in the input list, keep the first occurrence in the output list.

% nubBy :: (a -> a -> Bool) -> [a] -> [a]
% nubBy eq [] = []
% nubBy eq (x:xs) = x : nubBy eq [x' | x'<-xs, not (eq x x')]


% normalize :: Prop -> Prop that changes all variables in a proposition to 'a', 'b', 'c', etc. consistently.
% The variables' alphabetical order should match the order in which they first appear in the proposition if read as a String (from left to right).
% Suggestion: define an auxiliary function vars to list all variables in a proposition (as was done in the lectures).

% normalize :: Prop -> Prop
% normalize p = rename ((flip zip ['a' ..] . findUniqueNames) p) p
%   where
%     findUniqueNames = nubBy (==) . vars
%
% vars :: Prop -> [VarName]
% vars (Const _)  = []
% vars (Variable x) = [x]
% vars (Not p)    = vars p
% vars (And p q) = vars p ++ vars q
% vars (Imply p q) = vars p ++ vars q

% TESTE 2022

% type Species = (String, Int)
% type Zoo = [Species]

% isEndangered :: Species -> Bool, which receives a species and determines if it is endangered. A species is considered endangered
% if there are 100 or less individuals in the zoo

% isEndangered :: Species -> Bool
% isEndangered (_, count) = count <= 100

% updateSpecies :: Species -> Int -> Species, which, given a Species and an amount of newborn babies, returns a new instance of
% Species with the updated population.

% updateSpecies :: Species -> Int -> Species
% updateSpecies (name, oldCount) newCount = (name, newCount)

% updateSpecies :: Species -> Int -> Species
% updateSpecies (name, oldCount) newborns = (name, oldCount + newborns)

% filterSpecies :: Zoo -> (Species -> Bool) -> Zoo
% filterSpecies [] _ = []
% filterSpecies (animal:animals) f
%   | f animal  = animal : filterSpecies animals f
%   | otherwise = filterSpecies animals f

% countAnimals :: Zoo -> Int, which, given the list of species of a zoo, counts the total population of the zoo.
% Constraint: You must solve this exercise using higher-order functions. Recursion and list comprehensions are prohibited.

% countAnimals :: Zoo -> Int
% countAnimals animals = sum(map (\(name,count) -> count) animals)


% substring :: (Integral a) => String -> a -> a -> String, which returns the substring of a given string between an initial and final
% index (the character on the final index should also be included in the result; both indices are within bounds).
% Consider that the indices start at 0.

% substring xs start end = [c | (c,i) <- zip xs [0..], i >= start, i <= end]


