
const left = (x) => {
  return {
    value: x,
    map: function(f) {
      return x
    }
  }
}

const right = (x) => {
  return {
    value: x,
    map: function(f) {
      return f(x)
    }
  }
}


const div = (n,d) => {
  if(d === 0) {
    return new left("Divide by zero")
  }
  return new right(n/d)
}

const multiply = (m,n) => {
  if(typeof(m) !== 'number' || typeof(n) !== 'number') {
    return new left("Not a number")
  }
  return new right(m * n)
}


const r = div(1,10).map((r)=>{ return multiply(r, 100) }).value
r



