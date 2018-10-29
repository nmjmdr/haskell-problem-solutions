data Maybe' a = Nothing' | Just' a deriving Show

sqrt' :: (Floating a, Ord a) => a -> Maybe' a
sqrt' x = if x < 0 then Nothing' else Just' (sqrt x)


inv' :: (Floating a, Ord a) => a -> Maybe' a
inv' x = if x == 0 then Nothing' else Just' (1/x)

log' :: (Floating a, Ord a) => a -> Maybe' a
log' x = if x == 0 then Nothing' else Just' (log x)


sqrtInvLog' :: (Floating a, Ord a) => a -> Maybe' a
sqrtInvLog' x = case (sqrt' x) of
                 Nothing' -> Nothing'
                 (Just' y) -> case (inv' y) of
                               Nothing' -> Nothing'
                               (Just' z) -> log' z

-- case x of
-- Nothing -> Nothing
-- (Just y) -> f y

fMaybe' :: (Maybe' a) -> (a -> Maybe' b) -> Maybe' b
fMaybe' Nothing' _ = Nothing'
fMaybe' (Just' x) f = f x

-- Applying fMaybe' =>
sqrtInvLog'' :: (Floating a, Ord a) => a -> Maybe' a
sqrtInvLog'' x = (sqrt' x) `fMaybe'` (inv') `fMaybe'` (log')

-- now we can generalize the concept to any type, instead of just Maybe' by defining a Monad =>
class Monad' m where
 bind' :: m a -> (a -> m b) -> m b
 return' :: a -> m a

instance Monad' Maybe' where
 bind' Nothing' _ = Nothing'
 bind' (Just' x) f = f x
 return' x = Just' x

-- using Monad sqrtInvLog'' can be written as:
sqrtInvLog''' :: (Floating a, Ord a) => a -> Maybe' a
sqrtInvLog''' x = (sqrt' x) `bind'` (inv') `bind'` (log')

data ST a s = ST (a,s) deriving Show

strip :: ST a s -> (a,s)
strip (ST (a,s)) = (a,s)

sqrtST' ::(Floating a, Ord a) => ST a a -> ST (Maybe' a) a
sqrtST' (ST (x, s)) = ST (sqrt' x, s)

sqrtLogInvST' :: (Floating a, Ord a) => ST a a -> ST (Maybe' a) a
sqrtLogInvST' (ST (x,s)) = case (sqrt' x) of
                            Nothing' -> ST (Nothing', s)
                            (Just' y) -> case (log' y) of
                                          Nothing' -> ST (Nothing', s+y)
                                          (Just' z) -> ST (inv' z, s+y+z)

-- It is not possible to define a moand using the above definition as bind needs to be defined
-- as taking in a single type "m a"

-- In haskell state moand is defined using:
newtype State s a = State { runState :: s -> (a, s) }

applyState :: State s a -> s -> (a,s) 
applyState st s = undefined

fex1 :: Int->State Int Int
fex1 x = State { runState = \s->(r,(s+r)) } where r = x `mod` 2
                               
-- This works for runState, see how:
-- st = State { runState = \s-> (1,s) }
-- (runState st) 100
-- (1, 100)
-- Ref: https://stackoverflow.com/questions/10115623/accessing-members-of-a-custom-data-type-in-haskell
-- It seems to work because of record syntax shown below:
-- :t (runState st)
-- (runState st) :: Num a => s -> (a, s)

fex2 :: Int->State Int Int
fex2 x = State { runState = \s-> (r,s+r)} where r = x * 5


-- fex3 :: Int->State Int Int
fex3 x = (runState (fex2 y)) st where (st, y) = (runState (fex1 x)) 0 

-- Hardcoding of intial state of 0. To avoid, it has to now take the initial state as input

-- Now 's' acts as the intial state below:

fex3' :: Int -> State Int Int
fex3' x = State { runState = \s -> 
                                let (y, s') = (runState (fex1 x)) s in
                                  runState (fex2 y) s'
                }
-- and would be invoked with intial state as follows:
-- t = (fex3' 101)
-- (runState t) 10
-- (5,16)

-- taking this further to define a function that composes three functions:
fex4 :: Int -> State Int Int
fex4 x = State { runState = \s ->
                                let (y, s') = (runState (fex1 x)) s in
                                  let (y', s'') = (runState (fex2 y)) s' in                                       runState (fex2 y') s'' 
               }

-- (runState (fex4 101)) 20
-- (25,51)                                   

-- Now as we did with Maybe' let us try to reduce the complexity by extracting the common code patter

-- The common pattern should apply a function f given an earlier state output  (from an eariler function) aka fMaybe' like:
-- (sqrt' x) `fMaybe'` (inv') `fMaybe'` (log')
-- (fex1 x) `bindState` (fex2) `bindState` (fex2)  
bindState st f = State { runState = \s ->
                                      let (x, s') = (runState st) s in 
                                       (runState (f x)) s'
                       } 

fex4' ::  Int -> State Int Int
fex4' x = (fex1 x) `bindState` (fex2) `bindState` (fex2)

-- (runState (fex4' 101)) 20
-- (25,51)

-- based on bindState and Monad' definition, Moand' can be implemented as:
-- bind' st f, where st is of now type m a => (State s) a => State s a
instance Monad' (State s) where
 bind' st f = State { runState = \s -> 
                                    let (y, s') = (runState st) s in
                                     (runState (f y)) s'
                    }
 return' x = State { runState = \s -> (x,s) }

fex4'' x = (fex1 x) `bind'` (fex2) `bind'` (fex2)

-- (runState (fex4'' 101)) 20
-- (25,51)

-- Earlier attempts, but the attempt of partial application of type here is valid: 
--class Monad' m where
-- bind' :: m a -> (a -> m b) -> m b
-- return' :: a -> m a

-- instance Monad' (State s) where
-- This definition is important, we need to be able to define Monad' as
-- m a -> (a -> m b) ->m b
-- State take two parameters, thus does not fit the pattern of m a, but a partially applied type (State s) does fit (m a)



