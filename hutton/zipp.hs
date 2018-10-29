zipp::[a]->[b]->[(a,b)]
zipp [] _ = []
zipp _ [] = []
zipp (x:xs) (y:ys) = [(x,y)] ++ zipp xs ys 
