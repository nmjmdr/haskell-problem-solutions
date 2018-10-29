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


