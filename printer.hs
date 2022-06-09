-- Output html to file

-- type signatures

main = putStrLn myHtml 

html_ :: String -> String
html_ content = "<html>" <> content <> "</html>"

title_ :: String -> String
title_ content = "<html>" <> content <> "</title>"

head_ :: String -> String
head_ content = "<head>" <> content <> "</head>"

body_ :: String -> String
body_ content = "<body>" <> content <> "</body>"

myHtml = makeHtml "Title" "Content."

makeHtml :: String -> String -> String
makeHtml title content = html_ (head_ (title_ title) <> body_ content)
