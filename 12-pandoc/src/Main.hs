module Main where

import Text.Pandoc

textToConvert = unlines [ "Hello World."
                        , ""
                        , "    this is a Markdown code block"
                        , ""
                        , "[This is a link](http://www.latermuse.com/)" ]


Right pandocParsed = readMarkdown def textToConvert

pandocConverted = writeLaTeX def pandocParsed
convertedToHtml = writeHtmlString def pandocParsed
convertedToOpenDocument = writeOpenDocument opts pandocParsed
  where
    opts = def { writerWrapText = WrapAuto -- Enable text wrapping
               , writerColumns = 80 }  -- Set column width to 80

main :: IO ()
main = do
	print pandocParsed
	putStrLn ""
	putStrLn pandocConverted
	putStrLn ""
	putStrLn convertedToHtml
	putStrLn ""
	putStrLn convertedToOpenDocument
