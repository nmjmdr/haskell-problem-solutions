iteratex::(a->a)->a->[a]
iteratex f a = [a] ++ iteratex f (f(a))
