

fmap' :: (a->b) -> f a -> f b
fmap' = undefined
-- cant write the defintion for this becuase you cannot pattern match on f to be able to pattern match you should know what "f" is. This possible only when we use class and instances

class Functor' f where
 fmap'' :: (a -> b) -> f a -> f b

instance Functor' Maybe where 
 fmap'' _ Nothing = Nothing
 fmap'' fn (Just x) = Just (fn x)

