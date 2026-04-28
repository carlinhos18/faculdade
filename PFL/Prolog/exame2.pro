%author(AuthorID, Name, YearOfBirth, CountryOfBirth).
author(1, 'John Grisham', 1955, 'USA').
author(2, 'Wilbur Smith', 1933, 'Zambia').
author(3, 'Stephen King', 1947, 'USA').
author(4, 'Michael Crichton', 1942, 'USA').
%book(Title, AuthorID, YearOfRelease, Pages, Genres).
book('The Firm', 1, 1991, 432, ['Legal thriller']).
book('The Client', 1, 1993, 422, ['Legal thriller']).
book('The Runaway Jury', 1, 1996, 414, ['Legal thriller']).
book('The Exchange', 1, 2023, 338, ['Legal thriller']).
book('Carrie', 3, 1974, 199, ['Horror']).
book('The Shining', 3, 1977, 447, ['Gothic novel', 'Horror', 'Psychological horror']).
book('Under the Dome', 3, 2009, 1074, ['Science fiction', 'Political']).
book('Doctor Sleep', 3, 2013, 531, ['Horror', 'Gothic', 'Dark fantasy']).
book('Jurassic Park', 4, 1990, 399, ['Science fiction']).
book('Prey', 4, 2002, 502, ['Science fiction', 'Techno-thriller', 'Horror', 'Nanopunk']).
book('Next', 4, 2006, 528, ['Science fiction', 'Techno-thriller', 'Satire']).

% Implement book_author(?Title, ?Author), which associates a book title with the name of its author
book_author(T, A) :-
  book(T, Id, _, _, _),
  author(Id, A,_, _).

% Implement multi_genre_book(?Title), which unifies Title with the title of a book that has multiple genres
multi_genre_book(T) :-
  book(T, _,_,_ ,G),
  length(G, Res),
  Res > 1.

% Implement shared_genres(?Title1, ?Title2, CommonGenres), which receives two book titles as arguments and returns on the third argument a list containing the genres that are common to both books.
my_intersection([], _, []).
my_intersection([H|T], L2, [H|R]) :-
    member(H, L2), !,
    my_intersection(T, L2, R).
my_intersection([_|T], L2, R) :-
    my_intersection(T, L2, R).

shared_genres(T1, T2, Res) :-
  book(T1, _, _,_, G1),
  book(T2, _, _,_, G2),
  my_intersection(G1, G2, Res).

%Implement the similarity(?Title1, ?Title2, ?Similarity) predicate, which
%determines the Jaccard coefficient between the two books received as first two arguments, considering the genres of each book as
%the measure of similarity.
remove_dups([], []).
remove_dups([H|T], [H|R]) :-
    \+ member(H, T), !,
    remove_dups(T, R).
remove_dups([_|T], R) :-
    remove_dups(T, R).

similarity(T1, T2, S) :-
shared_genres(T1, T2, Shared),
book(T1, _ , _ , _ , G1),
book(T2, _ , _ , _ , G2),
append(G1, G2, Union),
remove_dups(Union, UnionNoDups),
length(Shared, L1),
length(UnionNoDups, L2),
S is L1 / L2 .


% gives_gift_to(Giver, Gift, Receiver)
gives_gift_to(bernardete, 'The Exchange', celestina).
gives_gift_to(celestina, 'The Brethren', eleuterio).
gives_gift_to(eleuterio, 'The Summons', felismina).
gives_gift_to(felismina, 'River God', juvenaldo).
gives_gift_to(juvenaldo, 'Seventh Scroll', leonilde).
gives_gift_to(leonilde, 'Sunbird', bernardete).
gives_gift_to(marciliano, 'Those in Peril', nivaldo).
gives_gift_to(nivaldo, 'Vicious Circle', sandrino).
gives_gift_to(sandrino, 'Predator', marciliano).

% Implement circle_size(+Person, ?Size), which unifies the second argument with the number of people who form the circle
% of gifts that includes the person received as first argument




