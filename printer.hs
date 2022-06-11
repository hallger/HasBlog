-- Output html to file

newtype Html = Html String
newtype Structure = Structure String
type Title = String

main :: IO ()
main = putStrLn myHtml

el :: String -> String -> String
el tag content = 
    "<" <> tag ">" <> content <> "</" <> tag <> ">"

p_ :: String -> String
p_ = Structure . el "p"

h1_ :: String -> String 
h1_ = Structure . el "h1"

html_ :: Title -> Structure -> Html
html_ title content = 
    Html 
        ( el "html" 
            ( el "head" (el "title" title)
                <> el "body" (getStructureString content)
            )
        )

myHtml :: Html
myHtml = makeHtml "Title" "Content."

makeHtml :: String -> String -> String
makeHtml title content = html_ (head_ (title_ title) <> body_ content)


-- editing functions
append_ :: Structure -> Structure -> Structure 
append_ (Structure a) (Structure b) = Structure (a <> b)

getStructureString :: Structure -> Structure 
getStructureString content = 
    case content of 
        Structure str -> str

render :: Html -> String
render html = 
    case html of
        Html str -> str
