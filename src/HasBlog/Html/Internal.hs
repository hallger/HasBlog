module HasBlog.Html.Internal where
import Numeric.Natural

-- Types

newtype Html = Html String
newtype Structure = Structure String
newtype Content = Content String
type Title = String

--  EDSL 

html_ :: Title -> Structure -> Html
html_ title content = 
    Html 
        ( el "html" 
            ( el "head" (el "title" (escape title))
                <> el "body" (getStructureString content)
            )   
        )   


p_ :: Content -> Structure
p_ = Structure . el "p" . getContentString

h_ :: Natural -> Content -> Structure
h_ n = Structure . el ("h" <> show n) . getContentString

h1_ :: String -> Structure 
h1_ = Structure . el "h1" .escape

ul_ :: [Structure] -> Structure
ul_ = Structure . el "ul" . concat .map(el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_ = Structure . el "ol" .concat . map(el "li" .getStructureString)

empty_ :: Structure
empty_ = Structure ""

instance Semigroup Structure where
    (<>) c1 c2 =
        Structure (getStructureString c1 <> getStructureString c2)

instance Monoid Structure where
    mempty = Structure ""

-- append
append_ :: Structure -> Structure -> Structure 
append_ c1 c2 =
    Structure (getStructureString c1 <> getStructureString c2) 

-- render 
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

getContentString :: Content -> String
getContentString content =
    case content of 
        Content str -> str

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
