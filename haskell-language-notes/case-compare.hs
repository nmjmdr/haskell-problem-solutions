module CaseCompare where

data Station = Para | Strath | Red | Cent | Town deriving (Eq, Ord, Show)

whichComesFirst :: (Station -> Station->Ordering) -> Station -> Station -> String
whichComesFirst cmp s1 s2 =
 case cmp s1 s2 of
  GT -> (show s1) ++ " after " ++ (show s2)
  LT -> (show s1) ++ " before " ++ (show s2)
  EQ -> " same station"

  
