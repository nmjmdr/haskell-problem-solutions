Lambda calculus

- Is left associative
```
(λx.x)(λy.y)z
= (λy.y)z
= z
````
Free variable ->
`λx.xy`
`y = free variable`

```
λxyz.x+y+z  = λx.λy.λz.x+y+z

Applied x = 1, y = 2, and z =3
λx.λy.λz.x+y+z (1)
λy.λz.1+y+z (2)
λz.1+2+z (3)
1+2+3
= 3
```
The above in Haskell will be as follows (partial application):
```
Prelude> let f x y z = x + y + z
Prelude> :info f
f :: Num a => a -> a -> a -> a     -- Defined at <interactive>:3:5
Prelude> let f1 = f 1
Prelude> :info f1
f1 :: Num a => a -> a -> a     -- Defined at <interactive>:5:5
Prelude> let f2 = f1 2
Prelude> :info f2
f2 :: Num a => a -> a     -- Defined at <interactive>:7:5
Prelude> let f3 = f2 3
Prelude> :info f3
f3 :: Num a => a     -- Defined at <interactive>:9:5
Prelude> f3
6
Prelude>
```
In JS:
```
const partialize = (f) => {
  return (x) => {
    return (y)=>{
      return (z) => {
        return f(x,y,z)
      }
    }
  }
}

const f = (x,y,z) => {
  return x + y + z
}

const addOne = partialize(f)(1)
const addTwoMore = addOne(2)
const addThreeMore = addTwoMore(3)
addThreeMore // equals 6
```
* Another amazing way to do partial application using e6 spread operatior is as follows:
```
function bindArgs(fn,...boundargs) {
  return function(...args) {
    return fn(...args, ...boundargs)
  }
}

let f = (x,y,z) => {
  return x + y + z
}

let addOne = bindArgs(f,1)
let addTwoMore = bindArgs(addOne, 2)
addTwoMore(3)

let addOneAndTwo = bindArgs(f, 1, 2)
addOneAndTwo(5)
```


Reduce:
```
(𝜆𝑥𝑦𝑧.𝑥𝑧(𝑦𝑧))(𝜆𝑚𝑛.𝑚)(𝜆𝑝.𝑝)
=(λx.λy.λz.xz(yz))(λn.λm.m)(λp.p)
=(λy.λz.(λn.λm.m)(z)(yz))(λp.p)
=(λy.λz.(λm.m)(yz))(λp.p)
=(λy.λz.yz)(λp.p)
=(λz.(λp.p)z)
=(λz.z)
=λz.z
```

### List of Tuples:
The following does not work, as the list has to be of the same type:
```
Prelude> let listOfTuples = [(1,"hello"),(2,3)]

<interactive>:33:36: error:
    • Could not deduce (Num [Char]) arising from the literal ‘3’
      from the context: Num t
        bound by the inferred type of
                 listOfTuples :: Num t => [(t, [Char])]
        at <interactive>:33:5-38
    • In the expression: 3
      In the expression: (2, 3)
      In the expression: [(1, "hello"), (2, 3)]
```

The following works:
```
Prelude> let listOfTuples = [(1,"hello"),(2,"3")]
Prelude> :t listOfTuples
listOfTuples :: Num t => [(t, [Char])]
Prelude>
```

data Bool = True | False

Implies:
Anytime the value True or False occurs in a Haskell program, the typechecker will know they’re members of the Bool type. The inverse is that whenever the type Bool is declared in a type signature, the compiler will expect one of those two values and only one of those two values; you get a type error if you try to pass a number where a Bool is expected

### Polymorphism
>> Parametric polymorphism is broader than ad-hoc polymorphism. 
>> Parametric polymorphism refers to type variables, or parameters, that are fully polymorphic. `When unconstrained by a typeclass, their final, concrete type could be anything.`


>> Constrained polymorphism, on the other hand, `puts typeclass constraints on the variable`, decreasing the number of concrete types it could be, but increasing what you can actually do with it by defining and bringing into scope a set of operations.

question: We can get a more comfortable appreciation of parametricity by looking at a -> a -> a. This hypothetical function a -> a -> a has two–and only two–implementations.
Write both possible versions of a -> a -> a. After doing so, try to violate the constraints of parametrically polymorphic values we outlined above
```
Prelude> let f::a->a->a; f x y = x
Prelude> let f::a->a->a; f y x = y
```

question: Only one version that will typecheck. `co :: (b -> c) -> (a -> b) -> a -> c`
```
let co::(b->c)->(a->b)->a->c; co bTOc aTOb = (bTOc . aTOb)
```
Note that the last a->c is always treated as (a->c) as that is the only feasible treatment.

Another example:
```
let d::a->b->c->a->c; d a b c  = \x->c
```

question: Only one version will typecheck: `a :: (a -> c) -> a -> a`

```
Prelude> let a :: (a -> c) -> a -> a; a fn a = a
Prelude> let c = 1
Prelude> let f a = c
Prelude> a f 100
100
```

question: only one version will typecheck: `a' :: (a -> b) -> a -> b` 

```
Prelude> let a' :: (a -> b) -> a -> b; a' fn a = fn(a)
````

question: `munge :: (x -> y) -> (y -> (w, z)) -> x -> w; munge=???`

```
let munge :: (x -> y) -> (y -> (w, z)) -> x -> w; munge fn1 fn2 x = fst(fn2(fn1(x)))
```

### Typeclasses
Typeclasses allow us to generalize over a set of types in order to define and execute a standard set of features for those types. For example, the ability to test values for equality is useful, and we’d want to be able to use that function for data of various types.

Point: 
For Bool
```
Prelude> :info Bool
data Bool = False | True     -- Defined in ‘GHC.Types’
instance Bounded Bool -- Defined in ‘GHC.Enum’
instance Enum Bool -- Defined in ‘GHC.Enum’
instance Eq Bool -- Defined in ‘GHC.Classes’
instance Ord Bool -- Defined in ‘GHC.Classes’
instance Read Bool -- Defined in ‘GHC.Read’
instance Show Bool -- Defined in ‘GHC.Show’
```

For Num:
```
Prelude> :info Num
class Num a where
  (+) :: a -> a -> a
  (-) :: a -> a -> a
  (*) :: a -> a -> a
  negate :: a -> a
  abs :: a -> a
  signum :: a -> a
  fromInteger :: Integer -> a
  {-# MINIMAL (+), (*), abs, signum, fromInteger, (negate | (-)) #-}
      -- Defined in ‘GHC.Num’
instance Num Word -- Defined in ‘GHC.Num’
instance Num Integer -- Defined in ‘GHC.Num’
instance Num Int -- Defined in ‘GHC.Num’
instance Num Float -- Defined in ‘GHC.Float’
instance Num Double -- Defined in ‘GHC.Float’
```


### Eq examples:

```
Prelude> data TisanInteger = Tisan Integer
Prelude> instance Eq TisanInteger where (==) (Tisan t1) (Tisan t2) = t1 == t2
Prelude> let t1 = Tisan 1
Prelude> let t2 = Tisan 2
Prelude> t1 == t2
False
```
The above works as expected.
Now the below:
```
Prelude> data Identity a = Identity a deriving Show
Prelude> instance Eq (Identity a) where (==) (Identity a1) (Identity a2) = a1 == a2

<interactive>:17:67: error:
    • No instance for (Eq a) arising from a use of ‘==’
      Possible fix: add (Eq a) to the context of the instance declaration
    • In the expression: a1 == a2
      In an equation for ‘==’:
          (==) (Identity a1) (Identity a2) = a1 == a2
      In the instance declaration for ‘Eq (Identity a)’
```


_Does not work, as there is no way for the compiler to identity which Eq typeclass instance it should apply. (As Haskell does not have the concept of universal equality)_

To rectity, (as indicated by the error: Possible fix: add (Eq a) to the context of the instance declaration). we need to `Eq a` to the context:

```
Prelude> instance Eq a => Eq (Identity a) where (==) (Identity a1) (Identity a2) = a1 == a2
Prelude> let i1 = Identity 1
Prelude> let i2 = Identity 2
Prelude> i1 == i2
False
```


Other examples:

```
data StringOrInt = TisInt Int | TisString String

instance Eq StringOrInt where
 (==) (TisInt t1) (TisInt t2) = t1 == t2
 (==) (TisString s1) (TisString s2) = s1 == s2
```

```
data Pair a =
 Pair a a

instance Eq a => Eq (Pair a) where
  (==) (Pair x x') (Pair y y') = x == y && x' == y'
```
 
_Note: The data constructor's are functions and can be applied partially too:_
```
*EqExamples> data Couple a = Couple a a deriving Show
*EqExamples> let c = Couple 1 2
*EqExamples> c
Couple 1 2
*EqExamples> let cPartial = Couple 1
*EqExamples> let c12 = cPartial 2
*EqExamples> c12
Couple 1 2
*EqExamples>
```

Interesting problem:
```
> let sum::Num a=> a->a->a; sum a b = a +b
> let partialSum = sum 1
> partialSum 2.0
3.0
```

In the following example:
```
> let sum::Num a=> a->a->a; sum a b = a +b
> let partialSum = sum 1
> partialSum 2.0
3.0
```
In step let partialSum = sum 1 it would appear that a is interpreted as Integer, but it cannot be because the ultimate result is Fractional (3.0)
But at this point let partialSum = sum 1 GHCI has to hold 1 in memory, How is `1` held?

Answer: Reference: https://stackoverflow.com/questions/48056655/haskell-how-is-num-held



