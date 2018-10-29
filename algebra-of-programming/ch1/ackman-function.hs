module AckmanFunction where

ack::(Num a, Eq a)=>(a,a)->a
ack (0,y) = y + 1
ack (x,0) = ack ( (x-1), 1 )
ack (x,y) = ack( (x-1), ack( (x,(y-1))))

