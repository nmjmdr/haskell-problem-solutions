# 5.8

1. Show that the terminal object is unique up to a unique isomorphism

"Unique up to a unique isomorphism" implies the following:
[Unique up to unique isomorphism means that there's only one isomorphism relating the two isomorphic objects.][1] 


The terminal object is the object with one and only one morphism coming to it from any object in the category. Or alternatively, T is terminal if for every object X in C there exists a single morphism X → T.

So if T1 and T2 are two terminal objects, we need to prove that there is ONLY ONE isomorphism that relates T1 and T2

By definition, "T is terminal if for every object X in C there exists a single morphism X → T."

Hence there is a single morphism from T1 to T2 and a single morphism from T2 to T1 (apart from identity morphisms on T1 and T2).  

Now T1->T2->T1 = id-t1 (identity) and T2->T1->T2 = id_t2 (identity). Thus T2 and T1 are isomprohic
Ref: [Comments of this question][2]

  [1]: https://math.stackexchange.com/questions/473420/what-is-the-difference-between-being-unique-unique-up-to-isomorphism-and-unique/473429
  [2]: https://math.stackexchange.com/questions/2574090/show-that-the-terminal-object-is-unique-up-to-a-unique-isomorphism



## Product and Coproducts

> A product of two objects `a` and `b` is the object `c` equiped with two projections p and q (`p::c-a and q::c->b`), such that for for any other object `c'` equiped with two projections (`p'::c'->a and q'::c'->b`) there is `unique morphism` `m` (`m::c'->c`) which factorizes `p'` and `q'` (`p' = p.m and q' = q.m`).

Example: consider c = 6 and p = /2 (divided by 2) and q = /3, then a = 3 and b = 2. 
For other objects c' equiped with p':c'->a and q':c'->b, comsider c' = 12, p' = /4 and q' = /6

Now we have a unique morphism m = /2, such that 12 / 2 = 6 => m:c'->c and p' = p . m = /2 (/2) and q' = q .m = /2 (/3) 

Another example (from The Catsers: Ref: https://www.youtube.com/watch?v=BqRkULEhG40)

Consider C = A x B, where A = {a,b}, B = {1, 2}. A x B = { {a,1}, {a, 2}, {b, 1}, {b, 2} }

p::C -> A and q::C->B, p and q map the element of cartesian product to its constiuent sets. 
Now if we have C' = { x, y, orange, mango } and a unique morphism m::C' -> C => x -> {a, b}, y -> {a, 2}, orange -> {b, 1}, mango -> {b, 2}

p' = p . m and q' = q . m

### Questions

2. What is the product of two objects in a poset?
> poset is defined as:
> The axioms for a non-strict partial order state that the relation ≤ is reflexive, antisymmetric, and transitive. That is, for all a, b, and c in P, it must satisfy:
> 1. a ≤ a (reflexivity: every element is related to itself).
> 2. if a ≤ b and b ≤ a, then a = b (antisymmetry: two distinct elements cannot be related in both directions).
> 3. if a ≤ b and b ≤ c, then a ≤ c (transitivity: if a first element is related to a second element, and, in turn, that element is related to a third element, then the first element is related to the third element).
 
`c` is a product equiped with projections to `a` and `b`. In case of poset this implies:

c ≤ a and c ≤ b
and for any other object `c'` there is unique morphism m::c'->c => c' ≤ c. 
Also p'= p . m =>  c' ≤ c ≤ a => c' ≤ a and q' => c' ≤ b

Thus c (product) is the greatest element such that c ≤ a and c ≤ b

3. What is coproduct of two objects in a poset?

> Coproduct:
> Coproduct of `a` and `b` is an object `c` such that it has injections: i::a->c,j::b->c 
> for any other object `c'`, has two injections i'::a->c' and j'::b->c'
> then there is a injection m::c->c'

In a poset:
i::a->c => a ≤ c and j::b->c => b≤c

Given another object c' with injections: i'::a->c' => a ≤ c' and j'::b->c' => b ≤ c'
There should be a unique morphism: m::c->c' => c ≤ c'
Thus the coproduct on two objects in a poset is an object which is the `least` such that a ≤ c and b ≤ c.

 
3. Implement equivalent of Haskell's `Either` as a generic type in your favorite language
 
Attempt 1: https://repl.it/repls/GloriousBrightBlackfly

Attempt 2: https://repl.it/repls/VisibleTimelyBlackandtancoonhound
Code:
```
// data Contact = Phone Int | Email String
// helpdesk :: Contact
// helpdesk = Phone 1234567

class Phone {
  constructor(number) {
    this.number = number
  }
  getter() {
    return this.number
  }
}

class Email {
  constructor(id) {
    this.id = id
  }
  getter() {
    return this.id
  }
}

class Either {
  constructor(left, right) {
    this.left = left
    this.right = right
  }
  isLeft() {
    return left !== null
  }
  isRight() {
    return right !== null
  }
  lefty() {
    return this.left.getter()
  }
  righty() {
    return this.right.getter()
  }
}

class Contact {
  constructor(either) {
    this.either = either
  }
}

var c = new Contact(new Either(new Phone(1234), null))
c.either.lefty()
```

Attempt 3: IMO, Either can very well be implemented as a Promise. We can chain promises, have it evaluated even with an error (to ofcourse an error result). 
```

class Either {
  constructor(fn) {
    this.fn = fn
    this.fn((lefty)=>{
      this.lefty = lefty
    },
    (righty)=>{
      this.righty = righty
    })
  }
  onLeft(callback) {
    if(this.lefty) {
      callback(this.lefty)
    }
    return this
  }
  onRight(callback) {
    if(this.righty) {
      callback(this.righty)
    }
    return this
  }
}


const div = (n,d) => {
  return new Either((left, right)=>{
    if(d === 0) {
      left("Divide by zero")
      return
    }
    right(n/d)
  })
}

div(1,10)
.onRight((r)=>{
  console.log("Result: ",r*10)
})
.onLeft((e)=>{
  console.log("Error: ",e)
})
```

Another possible approach:
```
class Either {
  constructor(fn) {
    this.fn = fn
    this.fn((lefty)=>{
      this.lefty = lefty
    },
    (righty)=>{
      this.righty = righty
    })
  }
  isLeft() {
    return this.lefty !== null
  }
  isRight() {
    return this.righty !== null
  }
}


const Contact = (phone, email) => {
  return new Either((left, right)=>{
    if(phone) {
      left(phone)
    } else {
      right (email)
    }
  })
}

var helpdesk = Contact(1234,null)

if(helpdesk.isLeft()) {
  console.log(helpdesk.lefty)
} else {
  console.log(helpdesk.righty)
}
```


Another attempt that is closer to Either of Haskell:
```
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
```
