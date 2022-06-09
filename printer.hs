-- Output html to file

main = putStrLn myHtml 

html_ content = "<html>" <> content <> "</html>"
title_ content = "<html>" <> content <> "</title>"
head_ content = "<head>" <> content <> "</head>"
body_ content = "<body>" <> content <> "</body>"

myHtml = makeHtml "Title" "Content."

makeHtml title content = html_ (head_ (title_ title) <> body_ content)
