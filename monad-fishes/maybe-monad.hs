-- This fike is only present to show the confused struggle with understanding of moands
-- Reference maybe-monad-v1.hs for better understanding

data Maybe' a = Just' a | Nothing' deriving Show

-- Fish Operator >=> :: (a -> m b) -> (b -> mc) -> (a -> mc)

-- (>=>) :: (a -> m b) -> (b -> m c) -> (a -> m c)
--(>=>) f g = \a -> let mb' = f a in bind' mb' g

-- bind' :: m b -> (b -> m c) -> m c
-- bind' :: m a -> (a -> m b) -> m b
-- bind' (m a) f = f a -- cannot really define bind' this was as m is type variable.s

class Monad' m where
 bind' :: m a -> (a -> m b) -> m b
 return' :: a -> m a

instance Monad' Maybe' where
 bind' Nothing' _ = Nothing'
 bind' (Just' x) f = f x
 return' x = Just' x


div' :: (Fractional a, Eq a) => a -> a -> Maybe' a
div' a b = if b == 0 then Nothing' else Just' (a / b) 

sqrt' :: (Floating a, Ord a) => a -> Maybe' a
sqrt' a = if a < 0 then Nothing' else Just' (sqrt a)


inv' :: (Fractional a, Eq a) => a -> Maybe' a
inv' x = if x == 0 then Nothing' else Just' (1 / x)

sqrtAndInv x = case (sqrt' x) of 
                Nothing' -> Nothing'
                (Just' y) -> inv' y


sqrtAndInv' x = bind' (sqrt' x) (inv')

over100 x = if x > 100 then (Just' x) else Nothing'

over100SqrtInv x = bind' (bind' (over100 x) (sqrt')) (inv')

over100SqrtInv' x = (over100 x) `bind'` (sqrt') `bind'` (inv') 
-- It would have been a but painful to write the above function as a series of nested case statements without the Monoid

divAndSqrt a b =  case (div' a b) of
                     Nothing' -> Nothing'
                     (Just' y) -> sqrt' y

-- How to use bind operator on a function taking more than one parameter?
-- come back to this question ^

-- Create another monad and use with above functions, Total Fractional that keeps adding results

data Total a = Total a deriving Show

instance Monad' Total where
 bind' (Total x) f = f x
 return' x = Total x

-- I want to maintain a running total of all operations performed:

-- over100SqrtInv x = bind' (bind' (over100 x) (sqrt')) (inv'), becomes:
-- over100SqrtInv x = bind' (bind' (bind' (over100 x) (someStateFn st)) (inv')) (someStateFn st)

-- how do we do this?
-- lets first attempt to do it without using the concept of monad


sqrtAndInvSt :: (Floating a, Ord a) => a -> a -> ((Maybe' a), a)
sqrtAndInvSt x st = case (sqrt' x) of
                     Nothing' -> (Nothing', st)
                     (Just' y) -> case (inv' y) of
                                   Nothing' -> (Nothing', st)
                                   (Just' r) -> ((Just' r), (st+r))


sqrtAndInvLog :: (Floating a, Ord a) => a -> ((Maybe' a), String) 
sqrtAndInvLog x = case (sqrt' x) of
                     Nothing' -> (Nothing', "sqrt failed")
                     (Just' y) -> case (inv' y) of
                                   Nothing' -> (Nothing', "sqrt ok, inv failed")
                                   (Just' r) -> ((Just' r), "sqrt and inv ok")

-- Above the code is getting repeated, how do we avoid it?
-- Just make the logging version symteric with the state one, we can do:
sqrtAndInvLog' :: (Floating a, Ord a) => a -> String->((Maybe' a), String)
sqrtAndInvLog' x l = case (sqrt' x) of
                      Nothing' -> (Nothing', l ++ "sqrt failed")
                      (Just' y) -> case (inv' y) of
                                    Nothing' -> (Nothing', l ++ "sqrt ok, inv failed")
                                    (Just' r) -> ((Just' r), l ++ "sqrt and inv ok")

-- How can we abstrct this?
-- attempt 1:

data Mnd a = Mnd a deriving Show

sqrtAndInvM :: (Floating a, Ord a) => a -> Mnd p -> (Mnd p -> Maybe' a -> Mnd q) -> Mnd q
sqrtAndInvM x p fn = case (sqrt' x) of
                       Nothing' -> fn p Nothing'
                       r  -> fn p r


sqrtAndInvMLog x = sqrtAndInvM x (Mnd ">") (\(Mnd p) r -> case r of 
                                                            Nothing' -> Mnd (p++" failed", Nothing')
                                                            r -> Mnd (p++" ok", r))

-- Log one:
sqrtAndInvMLog' x = sqrtAndInvM x (Mnd ">") (\(Mnd p) r -> case r of
                                                            Nothing' -> Mnd (p++" failed", Nothing')
                                                            (Just' r) -> let s = inv' r in case s of 
                                                                                             Nothing' -> Mnd (p++" sq ok, inv failed", Nothing')
                                                                                             t -> Mnd (p++" sq ok, inv ok", t))


-- State one:
sqrtAndInvMState' x = sqrtAndInvM x (Mnd 0) (\(Mnd p) r -> case r of
                                                            Nothing' -> Mnd (p, Nothing')
                                                            (Just' r) -> let s = inv' r in case s of
                                                                                             Nothing' -> Mnd (p+r, Nothing')
                                                                                             (Just' t) -> Mnd (p+r+t, (Just' t)))

 
-- Generic enough to apply, the problem is the repitition of case statements
-- define Monad' on Mnd
instance Monad' Mnd where
 -- bind' :: m a -> (a -> m b) -> m b
 bind' (Mnd x) f = f x
 return' x = Mnd x

-- first abstract the logic in each case statement to a single function:
-- fn (Maybe' a) (p) 
