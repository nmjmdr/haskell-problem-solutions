data Expr = Val Int | Div Expr Expr

safediv::Int->Int->Maybe Int
safediv _ 0 = Nothing
safediv x y = Just (x `div` y)


eval::Expr->Maybe Int
eval (Val x) = Just x
eval (Div x y) = case (eval x) of
                  Nothing -> Nothing
                  Just n -> case (eval y) of
                             Nothing -> Nothing
                             Just m -> safediv n m

bind'::(Maybe a)->(a->Maybe b)->Maybe b
bind' x fn = case x of
              Nothing -> Nothing
              Just n -> fn n

eval'::Expr->Maybe Int
eval' (Val x) = Just x
eval' (Div x y) = bind' (eval' x) (\n -> bind' (eval' y) (\m -> safediv n m)) 

class Applicative' f where
 purea :: a -> f a
 app :: f (a->b) -> f a -> f b


class Applicative' m =>  Monadd m where
 (>>|) :: m a -> (a -> m b) -> m b

instance Applicative' Maybe where
 purea = Just
 app (Just g) (Just x) = Just (g x)
 app Nothing _ = Nothing
 app _ Nothing = Nothing  

instance Monadd Maybe where
 (>>|) Nothing _ = Nothing
 (>>|) (Just x) f = f x

instance Applicative' [] where
 purea x = [x]
 app gs xs = [g x | g <- gs, x <- xs]

-- commented, refer to notes below on another implementation
-- instance Monadd [] where
-- (>>|) xs f = [ y | x <-xs, y <- f x] 

data Box a = Box a deriving Show

instance Applicative' Box where
 purea x = Box x
 app (Box g) (Box x) = purea (g x)

instance Monadd Box where
 (>>|) (Box a) g = (g a)

-- defining eval in terms of monadd:
evalm::Expr->Maybe Int
evalm (Val x) = Just x
evalm (Div x y) = (>>|) (evalm x) (\n -> (>>|) (evalm y) (\m -> safediv n m))

-- writing the same using infix notation
-- check why not working
-- evalm'::Expr->Maybe Int
-- evalm' (Val x) = Just x
-- evalm' (Div x y) = (evalm' x) (>>|) (\n -> (evalm' y) (>>|) (\m -> safediv n m))


-- *Main> (Box 1) >>| (\x-> Box (x + 1)) >>| (\x-> Box (x + 3)) >>| (\x -> Box (x+2))
-- Box 7 
-- the above could be expressed in do notation as:
-- do { (Box 1) (\x-> Box (x+1)) ..?

-- Monad for Box:
-- fmap :: (a -> b) -> f a -> f b (Minimal complete definition)
instance Functor Box where
 fmap g (Box x) = Box (g x)

instance Applicative Box where
 pure x = Box x
 (<*>) (Box g) (Box x) = pure (g x)

-- (>>=) m a -> (a -> m b) -> m b
instance Monad Box where
 (>>=) (Box x) g = g x

data List a = Empty | Cons a (List a) deriving Show

mapEach :: a -> [b] -> [(a,b)]
mapEach x [y]  = [(x,y)] 
mapEach x (y:ys) = [(x,y)] ++ mapEach x ys 

listPairs :: [a] -> [b] -> [(a,b)]
listPairs [] _ = []
listPairs _ [] = []
listPairs (x:xs) ys = (mapEach x ys) ++ (listPairs xs ys)


mapEach' :: a -> List b -> List (a,b)
mapEach' x (Cons y (Empty))  = Cons (x,y) (Empty)
mapEach' x (Cons y (l)) = Cons (x,y) (mapEach' x l)
 
listAppend :: List a -> List a -> List a
listAppend lx Empty = lx
listAppend Empty ly = ly
listAppend (Cons x lx) ly = Cons x (listAppend lx ly) 

listPairs' :: List a -> List b -> List (a,b)
listPairs' Empty _ = Empty
listPairs' _ Empty = Empty
listPairs' (Cons x lx) ly = listAppend (mapEach' x ly) (listPairs' lx ly)  

-- Now to define Applicative on List
-- purea :: a -> f a
--  app :: f (a->b) -> f a -> f b

applyEach :: (a->b) -> List a -> List b
applyEach f (Cons x (Empty)) = Cons (f x) (Empty)
applyEach f (Cons x (xs)) = Cons (f x) (applyEach f xs)

applyAll :: List (a->b) -> List a -> List b
applyAll _ Empty = Empty
applyAll Empty _ = Empty
applyAll (Cons f fs) xs = listAppend (applyEach f xs) (applyAll fs xs)   

instance Applicative' List where
 purea x = Cons x (Empty)
 app fs lx = applyAll fs lx 

-- (>>|) :: m a -> (a -> m b) -> m b
instance Monadd List where
 (>>|) Empty _ = Empty
 (>>|) (Cons x (lx)) f = listAppend (f x) ((>>|) lx f)

-- Example:
-- *Main> (>>|) (Cons 1 (Cons 2 (Cons 3 (Empty)))) (\x->(Cons (x+10) (Empty)))
-- Cons 11 (Cons 12 (Cons 13 Empty))

-- understanding the monad on [] 
-- Ref: https://stackoverflow.com/questions/51172904/haskell-monad-how-does-monad-on-list-work/51178620#51178620

-- an implementation that can be understood
instance Monadd [] where
  (>>|) [] f = []
  (>>|) (x:xs) f = let ys = f x in ys ++ ((>>|) xs f)

