# TP3 - Compiladores

## Transformation Left Recursion (2 steps)
- Introduce a new nonterminal
- Move recursion into A'

## Transformation Left Factoring (2 steps)
- Introduce a new nonterminal A' after common prefix A → αA' | β3
- Moves alternatives into A' A' → β1 | β2

# EX 3,6,9,10


## Problem 3

- Remove Left Recursion

A -> Aa | b

A -> bA' 
A' -> aA' | ϵ

## Problem 6

- Factor de following grammar:

A -> ab | ac

A -> aA'
A' -> b | c

## Problem 9

- Transform the following grammar so that it does not contain left recursion or common prefixes:

A -> A a b | A a c | d

Primeiro Left Recursion:

A -> dA'

A' -> abA' | acA' | ϵ

Left Factoring:

A -> dA'

A' -> aA'' | ϵ

A'' -> bA' | cA'

## Problem 10

- Consider the following grammar:

E -> T E'

E' -> + T E' | ε

T -> id

Write pseudo-code for the equivalent recursive descent functions, considering you have a match(terminal) function for terminals, and that if there is a problem, you should throw an error:
* void E()
* void Eprime()
* void T()

E()

    T() Eprime()

Eprime()

    if next == PLUS else return

    match(plus) T() Eprime()

T()

    match(ID)




