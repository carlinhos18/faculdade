% dish(Name, Price, IngredientGrams).
dish(pizza, 2200, [cheese-300, tomato-350]).
dish(ratatouille, 2200, [tomato-70, eggplant-150, garlic-50]).
dish(garlic_bread, 1600, [cheese-50, garlic-200]).

:- dynamic ingredient/2.

% ingredient(Name, CostPerGram).
ingredient(cheese, 4).
ingredient(tomato, 2).
ingredient(eggplant, 7).
ingredient(garlic, 6).

% count_ingredients(?Dish, ?NumIngredients), which determines how many different ingredients are needed to produce a dish.
count_ingredients(D, Num):-
  dish(D, _ ,  Ing),
  length(Ing, Num).

% Implement ingredient_amount_cost(?Ingredient, +Grams, ?TotalCost), which determines the total cost (in cents) of buying a certain amount (in grams) of an ingredient
ingredient_amount_cost(I, Gr, Tc) :- 
  ingredient(I, C),
  Tc is C * Gr.

%Implement dish_profit(?Dish, ?Profit), which determines the profit of selling a dish in the restaurant. A dish’s profit is the difference between its price and the combined cost of its ingredients.

profitByDish([],0).
profitByDish([Ing-Grams | Rest] , TotalCost) :-
  ingredient_amount_cost(Ing, Grams, Cost),
  profitByDish(Rest, Aux),
  TotalCost is Cost + Aux .

dish_profit(D, P) :-
  dish(D, PriceDish, List),
  profitByDish(List, Res),
  P is PriceDish - Res.

% Implement update_unit_cost(+Ingredient, +NewUnitCost), which modifies the knowledge base by updating the unit cost of an ingredient. If the ingredient does not exist, it should be added to the knowledge base. The predicate must always succeed.
update_unit_cost(Ingredient, NewUnitCost) :-
  retractall(ingredient(Ingredient, _)),
  assert(ingredient(Ingredient, NewUnitCost)).

% Implement most_expensive_dish(?Dish, ?Price), which determines the most expensive dish one can eat at the restaurant and its price. In case of a tie, the predicate must return, via backtracking, each of the most expensive dishes.
most_expensive_dish(D, P) :-
  dish(D, P, _),
  \+((
    dish(_,P2,_),
    P2 > P
  )).
:- use_module(library(lists)).

% Implement consume_ingredient(+IngredientStocks, +Ingredient, +Grams, ?NewIngredientStocks), which receives a list of ingredient stocks (as
% pairs of Ingredient-Amount), an ingredient, and an amount (in grams) and computes a new list obtained from removing the given amount
% of ingredient from the original stock. The predicate must only succeed if there is enough ingredient in stock.
% Constraint: In this question, and in this question only, you are not allowed to use recursion. Solutions using recursion will only receive up
% to 25% of the maximum score.

consume_ingredient(Is, Ing, Gr, Res) :-
  select(Ing-Grams, Is, Rest),
  Grams >= Gr,
  NewVal is Grams - Gr,
  Res = [Ing-NewVal | Rest].

% Implement count_dishes_with_ingredient(+Ingredient, ?N), which determines how many dishes use the given ingredient
count_dishes_with_ingredient(Ing, N) :-
    findall(
        Dish,
        (
            dish(Dish, _, Ingredients),
            member(Ing-_, Ingredients)
        ),
        Dishes
    ),
    length(Dishes, N).

% Implement list_dishes(?DishIngredients), which returns a list of pairs Dish-ListOfIngredients.
list_dishes(D) :-
  findall(
    Dish-IngNames,
    (
    dish(Dish,_,Ing),
    findall(Name, member(Name-_, Ing), IngNames)
    ),
    D
  ).

% Implement most_lucrative_dishes(?Dishes), which returns the restaurant’s dishes, sorted by decreasing amount of profit. In case of a tie, any
% order of the tied dishes will be accepted.

most_lucrative_dishes(Dishes) :- 
findall(
  Dish-Profit,
  dish_profit(Dish,Profit),
  LOL
),
keysort(LOL, SortedDishes),
reverse(SortedDishes, ReversedDishes),
pairs_values(ReversedDishes, Dishes).





%G1
edge(g1, br, o).
edge(g1, br, ni).
edge(g1, o, ni).
edge(g1, o, c).
edge(g1, o, h).
edge(g1, h, c).
edge(g1, h, n).
edge(g1, n, he).
edge(g1, c, he).
% G2
edge(g2, br, h).
edge(g2, br, ni).
edge(g2, h, ni).
edge(g2, h, o).
edge(g2, h, c).
edge(g2, o, c).
edge(g2, o, n).
edge(g2, n, he).
edge(g2, c, he).
edge(g2, cl, he).

% Implement common_edges(+G1, +G2, ?L), which, given the identifiers of two graphs (G1 and G2), computes their list of common edges
my_member(X, [X|_]).
my_member(X, [_|T]) :- my_member(X, T).

my_intersection([], _, []).
my_intersection([H|T], L2, [H|R]) :-
    my_member(H, L2), !,
    my_intersection(T, L2, R).
my_intersection([_|T], L2, R) :-
    my_intersection(T, L2, R).

calculate_graph(Graph, Edges):-
findall(
  Start-Finish,
  edge(Graph, Start, Finish),
  Edges
).

common_edges(G1, G2, L) :-
calculate_graph(G1, E1),
calculate_graph(G2, E2),
my_intersection(E1, E2, L).





