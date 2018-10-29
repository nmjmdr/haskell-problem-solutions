data Col  = Col String
data TypedCol t = TypedCol (Col) t

strCol = TypedCol (Col "Name") [Char]






