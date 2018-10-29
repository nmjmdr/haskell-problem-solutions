third1::[x]->x
third1 xs =
 head(tail(tail xs))

third2::[x]->x
third2 (_:_:x:_) = x 
