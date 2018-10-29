find::Eq a=>a->[(a,b)]->[b]
find a pairs = [v | (k, v) <- pairs, k == a]

