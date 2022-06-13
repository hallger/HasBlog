module Main where

import System.Directory (doesFileExist)
import System.Environment (getArgs)
import qualified Html
import qualified Markup

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

