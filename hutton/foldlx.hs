foldlx::(v->a->v)->v->[a]->v
foldlx f v [] = v
foldlx f v (x:xs) = foldlx f (f v x) xs

suml::Num a=>[a]->a
suml xs = foldlx (\x y->x+y) 0 xs

reversel::[a]->[a]
reversel xs = foldl (\v x->x:v) [] xs 
