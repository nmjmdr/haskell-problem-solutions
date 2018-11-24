class Functor' f where
    fmap' :: (a->b) -> f a -> f b

data ITree a = Leaf (Int->a) | Node [ITree a]


instance Functor' ITree where
    fmap' g (Leaf k) = Leaf (g.k)
    fmap' g (Node []) = Node []
    fmap' g (Node (t:ts)) = Node (b1++b2) where
                                          (Node b1) = (fmap' g (Node [t]))  
                                          (Node b2) = (fmap' g (Node ts))
                                          