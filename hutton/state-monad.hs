type State = Int
newtype ST a = S (State -> (a, State))

app :: ST a -> State -> (a, State)
app (S f) s = f s

instance Functor ST where 
 -- fmap :: (a -> b) -> m a -> m b
 fmap g s =  


