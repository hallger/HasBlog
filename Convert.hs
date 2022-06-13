module Convert where

import qualified Markup
import qualified Html
import Numeric.Natural

h_ :: Natural -> String -> Structure
h_ n = Structure . el ("h" <> show n) . escape

convertStruct :: Markup.Structure -> Html.Structure
convertStruct struct =
    case struct of
        Markup.Heading n txt -> 
            Html.h_ n txt

        Markup.Paragraph p -> 
            Html.p_ p
        
        Markup.UnorderedList list ->
            Html.ul_ $ map Html.p_ list

        Markup.OrderedList list -> 
            Html.ol_ $ map Html.p_ list


