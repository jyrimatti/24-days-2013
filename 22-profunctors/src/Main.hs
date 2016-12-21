{-# LANGUAGE ExistentialQuantification #-}
module Main where

import Data.Profunctor

data L a b = forall s. L (s -> b) (s -> a -> s) s

instance Profunctor L where
  dimap h f (L result iterate initial) =
    L (f . result) (\s -> iterate s . h) initial

runFold :: L a b -> [a] -> b
runFold (L result iterate initial) = result . foldl iterate initial

summer :: Num a => L a a
summer = L id (+) 0

testSummer :: Int
testSummer = runFold summer [1..10]

lengther :: L String String
lengther = dimap length (\s -> "The total length was " ++ show s) summer

testLengther :: String
testLengther = runFold lengther ["24", "days", "of", "hackage", "!"]

main :: IO ()
main = do
	print testSummer
	print testLengther
