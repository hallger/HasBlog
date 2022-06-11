module Html.Internal where

-- Types

newtype Html = Html String
newtype Structure = Structure String
type Title = String

-- Html tags

html_ :: Title -> Structure -> Html
html_ title content = 
    Html 
        ( el "html" 
            ( el "head" (el "title" (escape title))
                <> el "body" (getStructureString content)
            )   
        )   


p_ :: String -> Structure
p_ = Structure . el "p" . escape

h1_ :: String -> Structure 
h1_ = Structure . el "h1" .escape

ul_ :: [Structure] -> Structure
ul_ = Structure . el "ul" . concat .map(el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_ = Structure . el "ol" .concat . map(el "li" .getStructureString)

-- li_ :: String -> Structure 
-- li_ :: Structure . e1 "li" .escape

append_ :: Structure -> Structure -> Structure 
append_ c1 c2 =
    Structure (getStructureString c1 <> getStructureString c2) 


render :: Html -> String
render html = 
    case html of
        Html str -> str 

-- Utils

el :: String -> String -> String
el tag content = 
    "<" <> tag <> ">" <> content <> "</" <> tag <> ">" 

getStructureString :: Structure -> String 
getStructureString content = 
    case content of  
        Structure str -> str 

escape:: String -> String
escape =        
    let 
        escapeChar c = 
            case c of  
                '<' -> "&lt;"
                '>' -> "&gt;"
                '&' -> "&amp;"
                '"' -> "&quot;"
                '\'' -> "&#39;"
                _ -> [c] 
    in  
        concat . map escapeChar