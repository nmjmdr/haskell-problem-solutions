-- Extracted from comment of user dmwit 
-- ref: https://stackoverflow.com/q/50701827/46279
-- AntiZipList -- ZipList that extends the shorter list instead of cutting off the longer list
-- dmwit 2018-06-05 21:00:13.904753 UTC

{-# LANGUAGE DeriveFunctor #-}
import Control.Applicative
import Test.QuickCheck

newtype AZL a = AZL [a] deriving (Eq, Ord, Read, Show, Functor)

instance Applicative AZL where
	pure = AZL . pure
	AZL xs <*> AZL ys = AZL (go xs ys) where
		go [] _ = []
		go _ [] = []
		go [f] [x] = [f x]
		go [f] xs = map f xs
		go fs [x] = map ($x) fs
		go (f:fs) (x:xs) = f x : go fs xs

instance Arbitrary a => Arbitrary (AZL a) where
	arbitrary = AZL <$> arbitrary
	shrink (AZL xs) = AZL <$> shrink xs

type O = Ordering
type FO = AZL O
type OO = Fun O O
type FOO = AZL OO

prop_identity :: FO -> Bool
prop_identity v = (pure id <*> v) == v

prop_composition :: FOO -> FOO -> FO -> Bool
prop_composition u_ v_ w = (pure (.) <*> u <*> v <*> w) == (u <*> (v <*> w)) where
	u = applyFun <$> u_
	v = applyFun <$> v_

prop_homomorphism :: OO -> O -> Bool
prop_homomorphism f_ x = (pure f <*> pure x :: FO) == pure (f x) where
	f = applyFun f_

prop_interchange :: FOO -> O -> Bool
prop_interchange u_ y = (u <*> pure y) == (pure ($y) <*> u) where
	u = applyFun <$> u_
