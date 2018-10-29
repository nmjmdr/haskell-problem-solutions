class Either {
  constructor(value, errored) {
    this.value = value
    this.errored = errored
  }
  map(f){
    if(!this.errored) {
      return f(this.value)
    }
    return this
  }
}

class Errored extends Either {
  constructor(value) {
    super(value,true)
  }
}

class Result extends Either {
  constructor(value) {
    super(value,false)
  }
}


const div = (n,d) => {
  if(d === 0) {
    return new Errored("Divide by zero")
  }
  return new Result(n/d)
}

const multiply = (m,n) => {
  if(typeof(m) !== 'number' || typeof(n) !== 'number') {
    return new Errored("Not a number")
  }
  return new Result(m * n)
}


const r = div(1,10).map((r)=>{ return multiply(r, 100)})
