
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
 
-- thinking in term of function composition, aka fish operator =
-- ><>::(a ->m b) -> (b->m c)->(a->m c)
-- ><> (sqrt') (inv') = sqrtAndInv
-- Fish operator could be defined as follows:

-- ><> :: (a -> m b) -> (b -> m c) -> (a-> m c)
-- ><> fa fb = \x -> bindf (fa x) fb

-- where bindf is defined as
-- bindf :: m a -> (a -> m b) -> m b
-- bindf (Type x) f = f x
-- bindf ^ needs to be defined for specific types, which is actually done by `class Monad'`

-- Thus essentially function composition of type fish: (a -> m b) -> (b -> m c) -> (a-> m c) can be defined using bind

-- Further lets attempt to use this for state maintenence and logging, logging:
-- It needs to be able to fit the bind operator: bind :: m a -> (a -> m b) -> m b
-- We want the input to bind to accept and append to log statments, thus having something like => (String, a) -> (String, Maybe' a)
-- sqrt', inv', log' are of type (Floating a, Ord a) => a -> Maybe' a

-- Now we want to be able to take `sqrtInvLog'''` and embelish it in such way that, we are able to do:
-- print debug statements
-- maintain state

-- first attempt the specific version:
data ST a = ST (a, Maybe' a) deriving Show

sqrtSt :: (Floating a, Ord a)=> a -> a -> ST a
sqrtSt st x = let r = sqrt' x in case r of 
                                  Nothing' -> ST (st, Nothing')
                                  (Just' y) -> ST (st+y, (Just' y))

 
invSt :: (Floating a, Ord a)=> a -> a -> ST a
invSt st x = let r = inv' x in case r of
                                  Nothing' -> ST (st, Nothing')
                                  (Just' y) -> ST (st+y, (Just' y))


logSt :: (Floating a, Ord a)=> a -> a -> ST a
logSt st x = let r = log' x in case r of
                                  Nothing' -> ST (st, Nothing')
                                  (Just' y) -> ST (st+y, (Just' y))

-- bind' :: m a -> (a -> m b) -> m b
-- return' :: a -> m a

-- let us first define function which is similar to bind and manipulates the state and invokes the given function:
stBind :: (Floating a, Ord a) => ST a -> (a->a->ST a) -> ST a
stBind (ST (a, Nothing')) _ = ST (a, Nothing')
stBind (ST (s, (Just' y))) f = f s y


sqrtInvLogSt :: (Floating a, Ord a) => a -> a -> ST a
sqrtInvLogSt st x = (sqrtSt st x) `stBind` (invSt) `stBind` (logSt)

-- Another version:

sqrtSt' :: (Floating a, Ord a)=> ST a -> ST a
sqrtSt' (ST (st, Nothing')) = ST (st, Nothing') 
sqrtSt' (ST (st, (Just' x))) = let r = sqrt' x in case r of
                                                  Nothing' -> ST (st, Nothing')
                                                  (Just' y) -> ST (st+y, (Just' y))



invSt' :: (Floating a, Ord a)=> ST a -> ST a
invSt' (ST (st, Nothing')) = ST (st, Nothing')
invSt' (ST (st, (Just' x))) = let r = inv' x in case r of
                                                  Nothing' -> ST (st, Nothing')
                                                  (Just' y) -> ST (st+y, (Just' y))


logSt' :: (Floating a, Ord a)=> ST a -> ST a
logSt' (ST (st, Nothing')) = ST (st, Nothing')
logSt' (ST (st, (Just' x))) = let r = log' x in case r of
                                                  Nothing' -> ST (st, Nothing')
                                                  (Just' y) -> ST (st+y, (Just' y))

-- define stBind' here 
stBind' :: (Floating a, Ord a) => ST a -> (ST a->ST a) -> ST a
stBind' (ST (a, Nothing')) _ = ST (a, Nothing')
stBind' stx f = f stx

sqrtInvLogSt' :: (Floating a, Ord a) => ST a->ST a
sqrtInvLogSt' stx = (sqrtSt' stx) `stBind'` (invSt') `stBind'` (logSt')
-- works: 
-- sqrtInvLogSt' (ST (0,(Just' 100)))
-- ST (7.797414907005955,Just' (-2.3025850929940455))

-- Now can we define a bind' instead of stBind? -- attempt it

-- This does not work, as the type of "f" cannot be a -> m b, it is more of m a -> m a
-- instance Monad' ST where
--  bind' (ST (s, Just' x)) f = f (Just' x)
--  return' a = ST (a, Just' a )

-- Posted question on stackoverflow: https://stackoverflow.com/questions/52205421/haskell-unable-to-define-a-state-monad-like-function-using-a-monad-like-defini

newtype State' s a = State' (s -> (a,s))

stBind'' :: (Floating s,Floating a, Ord a) => State' s (Maybe' a) -> ( State' s (Maybe' a) -> State' s (Maybe' a)) -> State' s (Maybe' a)
stBind'' st f = f st

-- sqrtInvState'::(Floating a, Ord a) => a -> Maybe' a
-- sqrtInvSt' = undefined

-- st :: (Floating s, Floating a, Ord a) => s -> a -> State' s a
-- st s a = State' (\s -> (a,s))

sqrtState' x = (State' (\s->(sqrt' x,s)))

sqrtInvLogState'' x = (sqrtState' x) `stBind''` (\st -> st)

 





