class Functor' f where
    fmap' :: (a->b) -> f a -> f b

class Functor' f => Applicative' f where
    pure' :: a -> f a
    app :: f (a -> b) -> f a -> f b
   

instance Functor' [] where
   fmap' _ [] = []
   fmap' g (x:xs) = [(g x)] ++ fmap' g xs


instance  Applicative' [] where
    pure' x = [x]
    app gs xs = [g x | g <- gs, x <- xs]

-- app (take 3 (repeat (\x->x+1))) [1,2]
-- [2,3,2,3,2,3]

-- takes all possible combinations of list ^
-- thus we can say that it as `as contexts representing multiple results of a nondeterministic computation`

-- To define an applicative that takes a list of functions and applies it serially to "values" of lists (Thus considering
-- lists as collection of elements and not results of nondeterministic computation) we have:

newtype ZipList a = ZipList { getZipList :: [a] } deriving Show

instance Functor' ZipList where
    fmap' g zs =  ZipList { getZipList = [g x] ++ fmap' g xs } where 
                                                                (x:xs) = (getZipList zs)

instance Applicative' ZipList where
    pure' x = ZipList { getZipList = [x] }
    app gs xs = ZipList { getZipList = zs } where 
                                             zs = zipWith (\f x -> f x) (getZipList gs) (getZipList xs)
                                             