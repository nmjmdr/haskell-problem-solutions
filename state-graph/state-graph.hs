-- For a more straightforward type check GADT - state-graph-with-gadt.hs



data Val =  IntVal Int
         |  FloatVal Float
         |  StringVal String

data List = IntList [Int]
          | StringList [String]
          | FloatList [Float]

 
