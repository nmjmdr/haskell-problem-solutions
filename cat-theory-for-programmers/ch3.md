# Chapter 3

1. Generate a free category from:
 
 a. A graph with one node and no edges
    
    A -- f --> A, A -- g --> A, A -- g.f --> A, A -- id --> A

 b. A graph with one node and one directed edge
    
    A -- f --> A, A -- g --> A, A -- g.f --> A, A -- id --> A

 c. A graph with two nodes and a single arrow between them
    
    A -- f --> B, idA: A -- idA --> A, B -- idB --> B

 d. A graph with a single node and 26 arrows marked with letters of alphabet: a, b, c...z
    
    A composition for each arrow: b.a, c.a e.a ... z.a
   

2. What kind of order is this?
   
   a. A set of sets with inclusion relationship, A is included in B if every element of A is also an element of B
   
   Partial Order as: (--> : `included in`)
   
   A --> B --> C => A --> C
   
   A --> A
   
   If A --> B and B --> A => A is same as B
   
   Not total order because:
   
   If A --> C and B --> C, then may not imply A --> B

3. Considering that Bool is a set of two values True and False, show that it forms two (set-theortical) monoids with respect to, respectively operator && (AND) and ||| (OR).

function: AND as Monoid:

empty: True

append: x AND y

append composes and is associate: (x AND y) AND z = x AND (y AND z)

function: OR as Monoid:

empty: FALSE

append: x OR y

append composes and is asociative: (x OR y) OR z = x OR (y OR z)

4. Represent the Bool monoid with the AND operator as a category: List the morphisms and their rules of composition.

Bool is a single object category and as a set it has elements { True, False }

With AND as operations on set { True, False }, the mapping from Bool -> Bool is:

T AND T = T

T AND F = F

F AND T = F

F AND F = F

Fundamentally how do you represent the above table of binrary operations as mapping between Bool -> Bool?

. A monoid's append operation can be viewed as m -> (m -> m) => map an object 'm' to a function (m -> m).

. We need a way to map a cross product SxS -> S

. This can be done by imagining T AND T as T (AND T) (A mapping from m-> (m->m)), Thus we have:

T (AND T) = T

T (AND F) = F

F (AND T) = F

F (AND F) = F

Thus the morphisms are: (AND T) and (AND F)

(AND T) is the identity function, id(T) = T, id(F) = F

(AND F) is equivalent to `not` 

Do these morphisms from a category?

. clearly we have an identity function

. do they compose? not . id = not, id . not = id, exist and compose

. Associative? Yes: id . (not . id) = (id . not) .id


Hence Bool -- `not` --> Bool and Bool -- `id` --> Bool form a category, now is it monoid?

By definition a moniod is:

```
Monoid is an object M together with a collection of arrows {\displaystyle f:M\to M} {\displaystyle f:M\to M} that satisfy the following properties:

. For every pair of arrows f,g in M, the composition g . f arrow is also in M.
. Composition of arrows is associative. In other words for every triplet of arrows f, g, and h in M the equation h . ( g . f) = (h . g) .f holds.
There's a special arrow 1m called the identity arrow of M that satisfies 1m . f = f . 1m for every arrow f in M.
```

Ref: https://en.m.wikiversity.org/wiki/Introduction_to_Category_Theory/Monoids

Clearly we have identity arrow: id, which satisfies `1m . f = f . 1m` for every arrow f in M` as `id .not = not .id`





 
