# Chapter 1

1. Implement an identity function in your favourite language

`JavaScript`
```const id = (o) => o```

`Haskell has "id" function`


2. Implement compose function
`JavaScript`
```
const compose = (f,g)=> {
  return (x)=>{
    return g(f(x))
  }
}
```

`Haskell`
```
Prelude> let f x = x ++ "a"
Prelude> let g x = x ++ "b"
Prelude> let c = g.f
Prelude> c("c")
"cab"
-- 'g' after 'f'

Prelude> let c = f.g
Prelude> c("c")
"cba"
Prelude>
-- 'f' after 'g'
```

3. Write a program to test that your `compose` function respects identity
```
const id = (x) => x

const compose = (f,g)=> {
  return (x)=>{
    return g(f(x))
  }
}

const f = (x)=>x+1
const c = compose(id,f)

c(1) === f(1)
```

`Haskell`
```
Prelude> let c = f . id
Prelude> let f x = x + 10
Prelude> let c = f .id
Prelude> c(1)
11
```

