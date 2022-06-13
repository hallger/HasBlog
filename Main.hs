module Main where

import System.Directory (doesFileExist)
import System.Environment (getArgs)
import qualified Html
import qualified Markup
import Convert (convert)

main :: IO ()
main = do
    args <- getArgs 
    case args of 
        -- No arguments given
        [] -> do
            content <- getContents
            putStrLn (process "Empty" content)

        -- IO file paths given as args
        [input, output] -> do
            content <- readFile input
            exists <- doesFileExist output
            let 
                writeResult = writeFile output (process input content)
            if exists 
                then whenIO confirm writeResult
                else writeResult

        _ -> 
            putStrLn "Usage: runghc Main.hs [-- <input-file> <output-file>]"

process :: Html.Title -> String -> String
process title = Html.render . convert title . Markup.parse

confirm :: IO Bool
confirm = do
    putStrLn "Are you sure? (Y/n)"
    answer <- getLine
    case answer of
        "y" -> pure True
        "n" -> pure False
        _   -> do
            putStrLn "Invalid response."
            confirm


whenIO :: IO Bool -> IO () -> IO ()
whenIO cond action = do
    cond >>= \result -> 
        if result 
            then action
            else pure()


