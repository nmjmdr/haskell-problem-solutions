
factorial :: Float -> Float
factorial n = if n == 0 
                then 1
                else 
                  n * factorial (n - 1) 

factorial' :: Float -> Float

loop :: Float->Float->Float
loop acc n = if n == 0 then acc else loop (acc * n) (n-1)
factorial' n = loop 1 n 

