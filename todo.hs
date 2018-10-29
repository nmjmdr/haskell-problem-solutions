import Text.Read

data Status = NotDone | Done deriving Show
data Item = Item String Status
type Items = [Item]

addItem :: Item -> Items -> Items
addItem item items = item : items

delItem :: Int->Items->Items
delItem index [] = []
delItem index xs = (take index xs) ++ (drop (index+1) xs)

displayIndex::Int->Item->String
displayIndex index (Item x status) = (show index) ++ ". " ++ x ++ " > " ++ show status

displayItems :: Items -> String
displayItems xs = unlines (zipWith displayIndex [1..] (reverse xs))

mark :: Int->Status->Items->Items
mark index _ [] = []
mark index st xs = (take index xs) ++ [(Item str st)] ++ (drop (index+1) xs) where 
                                                                                      (Item str status) = xs!!index 


interactWithUser :: Items -> IO Items
interactWithUser items = do
 putStrLn "Enter an item: "
 itemString <- getLine
 let newItems = addItem (Item itemString NotDone) items
 putStrLn (displayItems newItems)
 pure newItems

data Command = Quit
             | DisplayItems
             | AddItem String 
             | MarkDone Int deriving Show

parseCommand :: String -> Either String Command
parseCommand "q" = Right Quit
parseCommand "p" = Right DisplayItems
parseCommand ('a':' ':item) = Right (AddItem item)
parseCommand ('m':' ':strIndex) =  case Text.Read.readMaybe strIndex of 
                                     (Just index) -> Right (MarkDone index)
                                     Nothing -> Left ("m index, could not parse index as integer")
parseCommand xs = Left ("Unable to parse: " ++ xs)

interactLoop :: Items -> IO Items
interactLoop items = do
 putStrLn "Commands: q: quit, p: print, a item: add item, m index: mark as done"
 cmdString <- getLine
 case parseCommand cmdString of 
  Right Quit -> do 
    pure(items)
  Right DisplayItems -> do
   putStrLn (displayItems items)
   interactLoop items
  Right (AddItem itemString) -> do
   let newItems = addItem (Item itemString NotDone) items
   putStrLn "Added: "
   putStrLn (displayItems newItems)
   interactLoop newItems
  Right (MarkDone index) -> do
   let newItems = mark index Done items
   putStrLn "Marked as done: "
   putStrLn (displayItems newItems)
   interactLoop newItems
  Left errMessage -> do
   putStrLn ("Err: "++errMessage)
   interactLoop items


