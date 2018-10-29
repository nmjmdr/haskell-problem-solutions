Given the following:
-- Insert image here


A definition of `optional` in JS:
```
const optional = (x) => {
  if(!x) {
    return {
      isValid: false
    }
  } else {
    return {
      isValid: true,
      value: x
    }
  }
}
```
The morhpisms:

```
const safe_reciprocal = (x) => {
  if(x>0) {
    return optional(1/x)
  } else {
    return optional()
  }
}

const safe_root = (x) => {
  if(x>=0) {
    return optional(Math.sqrt(x))
  } else {
    return optional()
  }
}


const compose = (f,g) =>(x) => {
    const fx = f(x)
    if(fx.isValid) {
      return g(fx.value)
    } else {
      return fx;
    }
}


//  safe_root . safe_reciprocal
const c = compose(safe_reciprocal, safe_root)
c(4)

// association
const safe_add1 = (x) => {
  if(x<1) {
    return optional(x + 1)
  } else {
    return optional()
  }
}

//safe_add1 . (safe_root . safe_reciprocal) 
// = (safe_add1 . safe_root ). safe_reciprocal
const c1 = compose(compose(safe_reciprocal, safe_root), safe_add1)
const c2 = compose(safe_reciprocal, compose(safe_root, safe_add1))

c1(4).value === c2(4).value

// identity with respect to composition:
const id = (x) => optional(x)
```


