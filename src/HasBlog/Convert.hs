module HasBlog.Convert where

import qualified HasBlog.Markup as Markup
import qualified HasBlog.Html as Html

convert :: Html.Title -> Markup.Document -> Html.Html
convert title = Html.html_ title . foldMap convertStruct

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