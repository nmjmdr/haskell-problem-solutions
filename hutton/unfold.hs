import Data.Char

unfold::(x->Bool)->(x->y)->(x->x)->x->[y]
unfold p h t x | p x = []
               | otherwise = (h x) : unfold p h t (t x)

genchars = unfold 
           (\x-> x == ((ord 'z') + 1)) 
           chr 
           (\x->x+1)

chop'::Int->[x]->[[x]]
chop' c  = unfold (\x->(length x) == 0) (take c) (drop c)

map'::(a->b)->[a]->[b]
map' f = unfold (\x->(length x) == 0) (\x->f (head x)) tail

iterate'::(a->a)->a->[a]
iterate' f = unfold 
              (\_->False) 
              (\x->f x) 
              (\x->f x)
  
