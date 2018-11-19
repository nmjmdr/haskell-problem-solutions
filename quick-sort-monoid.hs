-- brilliant excercise from: https://www.reddit.com/r/programming/comments/7cf4r/monoids_in_my_programming_language/c06adnx/

qsort :: (Ord a) => [a] -> [a]
qsort [] = []
qsort (x:xs) = qsort smaller ++ [x] ++ qsort larger
               where 
                smaller = [a | a <- xs, a <= x]
                larger = [a | a <- xs, a > x]


sortby :: (a->a->Ordering)->[a]->[a]
sortby _ [] = []
sortby cmp (x:xs) = sortby cmp smaller ++ [x] ++ sortby cmp larger
                    where 
                      smaller = [a | a <- xs, let ord = (cmp a x) in ord == LT || ord == EQ]
                      larger = [a | a <- xs, (cmp a x) == GT]

-- sortby (\a b -> compare (length a) (length b)) ["xyz","ab","ancd","abc","34f"]

comparing :: Ord r => (a->r) -> a -> a -> Ordering
comparing fn x y = compare (fn x) (fn y)

-- sortby (comparing length) ["xyz", "ab", "ancd", "abc"]

-- beacuse functions support monoids:
-- sortby (comparing length `mappend` compare) ["b","a","0","z0","b0","abcd","fgh"]
-- can be done ^

 
class Monoid' a where
 mempty' :: a
 mappend' :: a -> a -> a
 mconcat' :: [a] -> a
 mconcat' = foldr mappend' mempty'


instance Monoid' b => Monoid' (a->b) where
 mempty' = mempty'
 mappend' f g = \x -> (f x) `mappend'` (g x)   -- uses the mappend' of b to append results of f x and g x

instance Monoid' Ordering where
 mempty' = EQ
 mappend' LT _ = LT
 mappend' GT _ = GT
 mappend' EQ y = y


-- Works!
-- sortby (comparing length `mappend'` compare) ["b","a","0","z0","b0","abcd","fgh"]
-- ["0","a","b","b0","z0","fgh","abcd"] 
