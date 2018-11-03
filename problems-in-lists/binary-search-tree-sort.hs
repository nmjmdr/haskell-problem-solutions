
data BTree a = None | Node a (BTree a) (BTree a) deriving Show

insertIntoBTree :: Ord a => BTree a -> a -> BTree a
insertIntoBTree None x = Node x None None
insertIntoBTree (Node r ltree rtree) x | r > x = Node r (insertIntoBTree ltree x) rtree
                                       | otherwise = Node r ltree (insertIntoBTree rtree x)


inorder :: BTree a  -> [a]
inorder None = []
inorder (Node r ltree rtree) = (inorder ltree) ++ [r] ++ (inorder rtree)

listToBTree :: Ord a => [a] -> BTree a
listToBTree xs  = foldl (\tree x -> insertIntoBTree tree x) None xs


  
