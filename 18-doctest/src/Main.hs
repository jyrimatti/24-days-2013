module Main where

import Test.DocTest

{-| Given an integer, 'square' returns the same number squared:
>>> square 5
25

prop> \x -> square x == x+x
-}
square :: Int -> Int
square x = x * x

{-|
>>> :{
      let callback name = do
            putStrLn $ "Hello. Yes, this is " ++ name
>>> :}
>>> printer "Dog" callback
Dog says:
Hello. Yes, this is Dog
-}
printer :: String -> (String -> IO ()) -> IO ()
printer name callBack = do
  putStrLn $ name ++ " says:"

main  :: IO ()
main = doctest [ "src/Main.hs" ]
