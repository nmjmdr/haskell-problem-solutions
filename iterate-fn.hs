
iterate' :: (a->a) -> a -> [a]
iterate' f x = r : iterate' f r where 
                                 r = f x

data List' a = None | Cons a (List' a) deriving Show

append' :: a -> List' a -> List' a
append' x lx = Cons x (lx)

iterateList' :: (a->a) -> a -> List' a
iterateList' f x = r `append'` iterateList' f r where
                                                 r = f x
take' :: Int -> List' a -> List' a
take' _ None = None
take' n (Cons x lx)
          | n <= 0 = None
          | otherwise = Cons x (take' (n-1) lx)
 
