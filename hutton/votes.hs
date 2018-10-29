import Data.List

remdups::Eq a =>[a]->[a]
remdups [] = []
remdups (x:xs) = x : filter (/=x) (remdups xs)

count::Eq a=>a->[a]->Int
count x = length . filter (==x)

result::Ord a=>[a]->[(Int,a)]
result vs = sort [(count v vs, v) | v <- remdups vs]

winner::Ord a=>[a]->a
winner = snd.last.result

rank::Ord a=>[[a]]->[a]
rank = map snd.result.map head


remempty::[[a]]->[[a]]
remempty xs = [x | x <-xs, length x /= 0]

elim::Eq a=>a->[[a]]->[[a]]
elim e = map (filter (/=e))

winners'::Ord a=>[[a]]->a
winners' xs = case rank (remempty xs) of
              [c] -> c
              (c:cs) -> winners' (elim c xs)


