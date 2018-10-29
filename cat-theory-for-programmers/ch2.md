1. Implement a memoize function
```
const memoize = (f) => {
  let results = {}
  return (x)=>{
    if(results[x]) {
      console.log("Not calling f")
      return results[x]
    }
    const r = f(x)
    results[x] = r
    return r
  }
}

const f = (x)=> { 
  console.log("f called")
  return x*100
  
}

const fM = memoize(f)

fM(100);
fM(100);
fM(200);
```

5. How many different functions are there from Bool to Bool? Can you implement them all?
Bool -> Bool
{ T, F } -> { T, F }
T -> T
F -> F
T -> F
F -> T
```
const f = (x) => x 
const g = (x) => !x
-- Other way to do it would be:
const truther (x) => true
truther(true) = true // T -> T
truther(false) = true // F -> T

const falsifier = (x) => false
falsifier(true) = false // T -> F
falsifier(false) = false // F ->F
```

6. Draw a picture of a category whose only objects are the types Void, (), and Bool; with arrows corresponding to all possible functions between these types. Label the arrows with the names of the functions.
{ Void, Bool, () } -> { Void, Bool, () }

Possible functions:
> Void -> Bool
> Void -> ()
> Bool -> ()
> () -> ()
> () -> Bool
> Bool -> Bool

Further details:
a -- f --> b and b -- g --> c, there should be a -- g . f --> c
Given Void -> Bool, and Bool -> (), then there exists Void -> () (yes)
