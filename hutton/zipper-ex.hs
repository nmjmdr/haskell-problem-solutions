t = Fork 1 (Fork 2 (Deadend 3) (Deadend 4)) (Fork 5 (Deadend 6) (Deadend 7))
Data.Maybe.fromJust (turnRight (Data.Maybe.fromJust (turnRight ([],t))))
-- returns ([TurnRight 5 (Deadend 6),TurnRight 1 (Fork 2 (Deadend 3) (Deadend 4))],Deadend 7)
