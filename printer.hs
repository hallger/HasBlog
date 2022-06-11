import Html

main :: IO ()
main = putStrLn (render myHtml)

myHtml :: Html
myHtml = 
     html_ 
        "Title" 
        ( append_   
            (h1_ "heading" )
            (append_ 
                ( p_ "Here's some text")
                ( p_ "Here's some more text")
            )
        )

