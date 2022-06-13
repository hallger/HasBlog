module Main where

import System.Directory (doesFileExist)
import System.Environment (getArgs)
import qualified Html
import qualified Markup

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

confirm :: IO Bool
confirm = 
    putStrLn "Are you sure? (Y/n)" *>
        getLine >>= \answer -> 
            case answer of  
                "y" -> pure True
                "n" -> pure False
                _   -> putStrLn "Invalid response." *>
                    confirm


whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action = 
    cond >>= \result -> 
        if result 
            then action
            else pure()


