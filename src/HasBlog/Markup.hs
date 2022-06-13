module HasBlog.Markup
    ( Document
    , Structure(..)
    , parse
    )
where

import Numeric.Natural
import Data.Maybe (maybeToList)

type Document 
    = [Structure]

data Structure  
    = Heading Natural String
    | Paragraph String
    | UnorderedList [String]
    | OrderedList [String]
    deriving (Eq, Show)

trim :: String -> String
trim = unwords . words

parse :: String -> Document 
parse = parseLines Nothing . lines

parseLines :: Maybe Structure -> [String] -> Document
parseLines context txts =
    case txts of
        [] -> maybeToList context

        -- h1
        ('*': ' ': line) : rest -> 
            maybe id (:) context (Heading 1 (trim line) : parseLines Nothing rest)

        -- ul
        ('-' : ' ' : line) : rest -> 
            case context of 
                Just (UnorderedList list) ->
                    parseLines (Just (UnorderedList (list <> [trim line]))) rest

                _ ->
                    maybe id (:) context (parseLines (Just (UnorderedList [trim line])) rest)
       
        -- ol
        ('#' : ' ' : line) : rest ->
            case context of 
                Just (OrderedList list) -> 
                    parseLines (Just (OrderedList (list <> [trim line]))) rest


                _ -> 
                    maybe id (:) context (parseLines (Just (OrderedList [trim line])) rest)

        -- p
        currentLine : rest -> 
            let 
                line = trim currentLine
            in 
                if line == "" 
                    then 
                        maybe id (:) context (parseLines Nothing rest)
                    else 
                        case context of 
                            Just (Paragraph paragraph) -> 
                                parseLines (Just (Paragraph (unwords [paragraph, line]))) rest
                            _ -> 
                                maybe id (:) context (parseLines (Just (Paragraph line)) rest)






