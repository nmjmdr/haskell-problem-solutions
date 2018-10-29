module TypesExample where

data Blah = Meh | Bleh deriving Show

bleat::Blah->Blah
bleat Meh = Bleh
bleat _ = Meh



