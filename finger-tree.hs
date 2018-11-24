
data Tree v a = Leaf v a | Branch v (Tree v a) (Tree v a) deriving Show

toList :: Tree v a -> [a]
toList (Leaf _ a) = [a]
toList (Branch _ l r) = toList l ++ toList r
 
tag :: Tree v a -> v
tag (Leaf v _) = v
tag (Branch v _ _) = v

head' :: Tree v a -> a
head' (Leaf _ a) = a
head' (Branch _ l _) = head' l

type Size = Int

leaf :: a -> Tree Size a
leaf a = Leaf 1 a

branch :: Tree Size a -> Tree Size a -> Tree Size a
branch x y = Branch (tag x + tag y) x y

-- index starts at 0
nth :: Tree Size a -> Int -> a
nth (Leaf _ a) 0 = a
nth (Branch _ x y) n | n < tag x = nth x n
                     | otherwise = nth y (n - tag x) -- subtract size of left tree and go into right tree
nth _ _ = error "Wrong index passed"

-- priority queue
type Priority = Int

leaf' :: (Priority,a) -> Tree Priority a
leaf' (p,a) = Leaf p a

branch' :: Tree Size a -> Tree Size a -> Tree Size a
branch' x y = Branch (tag x `min` tag y) x y

tag' :: Tree Priority a -> Priority
tag' (Leaf p _) = p
tag' (Branch _ x y) = tag' x `min` tag' y

head'' :: Tree Priority a -> a
head'' t = case t of
            (Leaf _ a) -> a
            (Branch _ x y ) -> if tag' x == tag' t
                                then head'' x
                                else 
                                 head'' y


-- use case for monoid:
-- branch :: Tree Size a -> Tree Size a -> Tree Size a
-- branch x y = Branch (tag x + tag y) x y

-- branch' :: Tree Size a -> Tree Size a -> Tree Size a
-- branch' x y = Branch (tag x `min` tag y) x y
--

-- instance Monoid Size where
--    mempty = 0
--    mappend = (+)

-- instance Monoid Priority where
--    mempty = maxBound
--    mappend = min

-- Hence, a unified smart constructor reads

-- branch :: Monoid v => Tree v a -> Tree v a -> Tree v a
-- branch x y = Branch (tag x <> tag y) x y
-- For leaves, the tag is obtained from the element. We can capture this in a type class

-- class Monoid v => Measured a v where
--     measure :: a -> v
-- so that the smart constructor reads

-- leaf :: Measured a v => a -> Tree v a
-- leaf a = Leaf (measure a) a
-- For our examples, the instances would be

-- instance Measured a Size where
--     measure _ = 1            -- one element = size 1

-- instance Measured Foo Priority where
--     measure a = priority a   -- urgency of the element
