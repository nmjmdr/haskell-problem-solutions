data NestedList a = NestedList a (NestedList a) |  Elem a deriving Show

-- l = NestedList 1 (NestedList 2 (Elem 3))
-- flatten to: [1,2,3]

flattenToList :: NestedList a -> [a]
flattenToList (Elem x) = [x]
flattenToList (NestedList x (xs)) = [x] ++ flattenToList xs

-- to be able to use foldr NestedList should be "Foldable"
-- implement foldr'

foldr' :: ((NestedList a)->b->b) -> b -> NestedList a-> b
foldr' f b (Elem x) = f (Elem x) b
foldr' f b (NestedList x ns) = foldr' f (f (Elem x) b) ns

flattenToList' :: NestedList a -> [a]
flattenToList' ns = foldr' (\(Elem x) acc -> acc ++ [x]) [] ns
  
    
 
