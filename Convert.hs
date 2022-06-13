module Convert where

import qualified Markup
import qualified Html

convertStruct :: Markup.Structure -> Html.Structure
convertStruct struct =
    case struct of
        Markup.Heading 1 txt -> 
            Html.h1_ txt

        Markup.Paragraph p -> 
            Html.p_ p
        
        Markup.UnorderedList list ->
            Html.ul_ $ map Html.p_ list

        Markup.OrderedList list -> 
            Html.ol_ $ map Html.p_ list

