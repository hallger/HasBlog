-- command line parsing 

module OptParse
    ( Options(..) 
    , SingleInput(..)
    , SingleOutput(..)
    , parse 
    )
    where

import Data.Maybe (fromMaybe)
import Options.Applicative 

data Options
    = ConvertSingle SingleInput SingleOutput 
    | ConvertDir FilePath FilePath 
    deriving Show

data SingleInput 
    = Stdin
    | InputFile FilePath
    deriving Show

data SingleOutput 
    = Stdout 
    | OutputFile FilePath
    deriving Show

parse :: IO Options 
parse = execParser opts 

opts :: ParserInfo Options 
opts = 
    info (pOptions <**> helper) 
    (   fullDesc
        <> header "HasBlog - Static Site Generator" 
        <> progDesc "Convert markup to html" 
    )

pOptions :: Parser Options 
pOptions = 
    subparser 
        ( command 
          "convert" 
          ( info 
            (helper <*> pConvertSingle)
            (progDesc "Convert a single markup source to html")
          )

            <> command 
            "convert-dir" 
            ( info 
              (helper <*> pConvertDir) 
              (progDesc "Convert a Directory of markup files to html") 

            )
        )



pConvertSingle :: Parser Options 
pConvertSingle = 
    ConvertSingle <$> pSingleInput <*> pSingleOutput


pSingleInput :: Parse SingleInput 
pSingleInput = 
    fromMaybe Stdin <$> optional pInputFile

pSingleOutput :: Parser SingleOutput 
pSingleOutput =
    fromMaybe Stdout <$> optional pOutputFile

pOutputFile :: Parser SingleOutput 
pOutputFile = OutputFile <$> parser 
    where 
        parser = 
            strOption
                ( long "output" 
                    <> short 'o'
                    <> metavar "FILE" 
                    <> help "Output file" 
                )

pConvertDir :: Parser Options 
pConvertDir = 
    ConvertDir <$> pInputDir <$> pOutputDir


pInputDir :: Parser FilePath
pInputDir = 
    strOption 
    ( long "input" 
      <> short 'i'
      <> metavar "DIRECTORY" 
      <> help "Input Dir"
    )

pOutputDir :: Parser FilePath
pOutputDir = 
    strOption 
        ( long "output" 
          <> short 'o' 
          <> metavar "DIRECTORY" 
          <> help "Output Dir" 
        )
