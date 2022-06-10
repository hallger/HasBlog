-- Output html to file

-- type signatures

main = putStrLn myHtml 

el :: String -> String -> String
el tag content = 
    "<" <> tag ">" <> content <> "</" <> tag <> ">"

p_ :: String -> String
p_ = el "p"

h1_ :: String -> String 
h1_ = el "h1"

html_ :: String -> String 
html_ = el "html"

title_ :: String -> String
title_ = el "title"

head_ :: String -> String
head_ = el "title"

body_ :: String -> String 
body_ = el "body" 

myHtml :: String
myHtml = makeHtml "Title" "Content."

makeHtml :: String -> String -> String
makeHtml title content = html_ (head_ (title_ title) <> body_ content)
