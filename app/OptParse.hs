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

-- model
data Options
    = ConvertSingle SingleInput SingleOutput 
    | ConvertDir FilePath FilePath 
    deriving Show

-- single input source
data SingleInput 
    = Stdin
    | InputFile FilePath
    deriving Show

-- single output sink
data SingleOutput 
    = Stdout 
    | OutputFile FilePath
    deriving Show

-- parse command line opts
parse :: IO Options 
parse = execParser opts 

opts :: ParserInfo Options 
opts = 
    info (pOptions <**> helper) 
    (   fullDesc
        <> header "HasBlog - Static Site Generator" 
        <> progDesc "Convert markup to html" 
    )

-- parser for all options
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



-- parser for single source to sink option
pConvertSingle :: Parser Options 
pConvertSingle = 
    ConvertSingle <$> pSingleInput <*> pSingleOutput


-- parser for single input
pSingleInput :: Parser SingleInput 
pSingleInput = 
    fromMaybe Stdin <$> optional pInputFile

--  parser for single output
pSingleOutput :: Parser SingleOutput 
pSingleOutput =
    fromMaybe Stdout <$> optional pOutputFile

pInputFile :: Parser SingleINput
pInputFile = fmap InputFile parser 
    where
        parser = 
            strOption
                ( long "input" 
                  <> short 'i' 
                  <> metavar "FILE" 
                  <> help "Input File" 
                )

-- output file parser
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

-- dir conversion parser
pConvertDir :: Parser Options 
pConvertDir = 
    ConvertDir <$> pInputDir <$> pOutputDir

-- parser for input dir
pInputDir :: Parser FilePath
pInputDir = 
    strOption 
    ( long "input" 
      <> short 'i'
      <> metavar "DIRECTORY" 
      <> help "Input Dir"
    )

-- parser for output dir
pOutputDir :: Parser FilePath
pOutputDir = 
    strOption 
        ( long "output" 
          <> short 'o' 
          <> metavar "DIRECTORY" 
          <> help "Output Dir" 
        )
