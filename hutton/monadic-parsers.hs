import Data.Char

type Parser a = String -> [(a,String)]

result :: a -> Parser a
result v = \input -> [(v,input)]

zero :: Parser a
zero = \input -> []

item :: Parser Char
item = \input -> case input of
                [] -> []
                (x:xs) -> [(x,xs)]

seq' :: Parser a -> Parser b -> Parser (a,b)
seq' pa pb = \input -> [((v,w), input'') | (v,input') <- pa input, (w,input'') <- pb input']

-- Example of sequential application of parsers
capFirst :: Parser String
capFirst = \input -> [([Data.Char.toUpper (head input)], tail input)]

appendZeroFirst :: Parser String
appendZeroFirst = \input -> [ ( (head input) : "0", tail input) ]

-- Ex:
-- seq' capFirst appendZeroFirst "hello"
-- [(("H","e0"),"llo")]

-- The problem with :
-- seq' :: Parser a -> Parser b -> Parser (a,b)
-- seq' pa pb = \input -> [((v,w), input'') | (v,input') <- pa input, (w,input'') <- pb input']
-- is the nesting of tuples: (v,input') <- pa input, (w,input'') <- pb input' is verbose and the same operation 
-- is performed twice
-- more importantly seq cannot be chained, if want to apply three parsers sequentially, can I declare a method for it?
-- Going by the signature, I would have to declare:
-- seq' :: Parser a -> Parser b -> Parser c -> Parser (a,b,c)

-- to avoid this the bind operator is defined:
bind :: Parser a -> (a -> Parser b) -> Parser b
bind pa fn = \input ->  concat[(fn v) input' | (v,input') <- pa input]

-- How the above comes about?
-- Look at the type definition what do we have:
-- pa => Parser a 
-- f => (a -> Parser b)
-- We could start by applying pa to input :
-- bind pa f = \input = (This is the return value of bind \input is String, and what we return below should be [(b,string)]
--                   pa input ==> [(v,input')]
--                   (f v) => which gives Parser b, which can then be applied to input', thus:
--                   (f v) input ' => [(w,input'')]
-- This can be acheived using the list comprehension:
-- bind pa f = \input = concat [ (f v) input'  | (v,input') <- pa input]
-- concat is required as we would end up getting: [ [ (w, input'')] ], concat flattens it to : [ (w,input'')]
-- An important point to notice is that f is receiving the output of pa, thus it can be accumulated.

-- To apply a series of parsers, we would:
-- p1 `bind` \x1 ->
-- p2 `bind` \x2 ->
-- p3 `bind` \x3 ->
-- pn `bind` \xn ->
--  result (fn x1, x2,..xn)
-- fn combines the results into a single value and passes it along to result function defined above

-- to redefine seq' in terms of bind:
seq'' :: Parser a -> Parser b -> Parser (a,b)
seq'' pa pb = bind pa (\x -> bind pb (\y -> result (x,y)))

