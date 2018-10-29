Chapter 1

Simplify:
(add(succ(pred zero))zero).

Given:
1. ( succ (pred e)) => e
2. ( pred ( succ e) ) => e

3. ( add zero e2) => e2
4. ( add ( succ e1 ) e2) => ( succ ( add el e2))
5. ( add (pred e1) e2) => (pred ( add e1 e2))

(add (succ(pred zero)) zero )
(add e2 zero) = e2
succ(pred zero)
= zero

Prove that the the process of reduction must always terminate for any given initial expression

Given expressions 1 to 5. 
If we define expression size as (operator operand) = 1. Hence operator (operator operand) = 2
Expressions 1, 2 and 3 reduces the size of expressions when applied. Expression 4 and 5 keep the size same.
Thus given and expression it can either remain same or reduce at each step, hence it termintes.

Excercise 1.2.3

```
data Exp = Zero | Succ Exp | Pred Exp deriving Show


reduce::Exp->Exp
reduce (Succ(Pred e)) = reduce e
reduce (Pred(Succ e)) = reduce e
reduce e = e
```

