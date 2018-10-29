```
c_ -- p_ --> a
c_ -- q_ --> b


c -- p --> a
c -- q --> b

c_ -- m --> c

(where c = (a,b))

Product of two objects `a` and `b` is `c`, such that there are morhpisms `p` and `q`
such that c -- p --> a and c -- q --> b.

If there is another product `c_` there is always a morhpism `m` such that
p_ = p . m
q_ = q . m

```
In JS:
``` 
const p_ = (x) => x
const q_ = (x) => true

const p = (pair) => pair.x
const q = (pair) => pair.y

const m = (x) => { return { x:x, y:true } }

const p_alt = (x) => p(m(x))
const q_alt = (x) => q(m(x))

p_(1) == p_alt(1) && q_(1) == q_alt(1)

```
Ultimately we can say that pair = { x:x, y:y } represents a product of x and y


Another way to construct  `m` is:
```
const m_another = (x) => { return { x:p_(x), y:q_(x) }  }
```
We can always define a `m` given `p_` and `q_` bu having the following higher order function:

```
const m_creator = (p_, q_) => {
  return (x) => {
    { return { x:p_(x), y:q_(x) }  }
  }
}
```

m_creator is refered to as `factorizer` function

In haskell a pair can be represented by (a,b), thus ins haskell we would have:
```
Prelude>
Prelude> let p_ x = x
Prelude> let q_ x = True
Prelude> let p (x,_) = x
Prelude> let q (_,y) = y
Prelude> let m x = (x,True)
Prelude>
Prelude>
Prelude> let p_alt = p.m
Prelude> let q_alt = q.m
Prelude>
Prelude> p_alt(1)
1
Prelude> p_alt(1) == p_(1)
True
Prelude> q_alt(1) == q_(1)
True
Prelude>
```

For the factorizer (or m_creator), we would have:

```
Prelude> let factorizer p_ q_ = \x -> (p_(x),q_(x))
Prelude> let f = factorizer p_ q_
Prelude> f(1)
(1,True)
Prelude>
```

Note that c -- p --> a and c -- q --> b is a product, if 
p_ = p . m
q_ = q . m

but the opposite is not true, p = p_ . m_ and q = q_ . m_ (some m__)

Example: p :: (Int,Bool) -> Int, q :: (Int,Bool) -> Int
p_ :: Int -> Int and q_ :: Int -> Bool
m_ :: (Int, Bool) -> Int

```
m_ :: (Int,Bool) -> Int
m_ (x,y) = y

p_ :: Int -> Int
p_ x = x

q_ :: Int -> Bool
q_ _ = True

p::(Int,Bool) -> Int
p (x,_) = x

q::(Int,Bool) -> Bool
q::(_,y) = y

m_::(Int,Bool) -> Int
m_ (x,_) = x
```


We can construct p_alt = p_ . m_, and p_alt = p, that works
But given q_alt = q_ . m _,  q_alt != q as:
```
Prelude> q_alt (1, False)
True
Prelude> q_alt (1, True)
True
Prelude> q (1, True)
True
Prelude> q (1, False)
False
``` 

Information is lost with q_ as q_ can only return either True or False, where q can return True or False depending on value of y 
