type Pair a = (a,a)

type NumPair = Pair Int

type CharPair = Pair Char

numpairs = [(1,2),(3,4)]::[NumPair]

numpairs2 = [(1,2),(3,4)]::[(Pair Int)]

type Assoc k v = [(k,v)]

numberedchars = [(1,'a'),(2,'b')]::Assoc Int Char

-- numberedchars++[(3,'c')]

appendToAssoc::(Assoc k v)->(k,v)->(Assoc k v)
appendToAssoc l p = l ++ [p]

find :: (Eq k) => k -> Assoc k v -> v
find k l = head [ v' | (k',v') <- l, k == k' ]

findAll :: (Eq k) => k -> Assoc k v -> [v]
findAll k l = [ v' | (k',v') <- l, k == k' ]


