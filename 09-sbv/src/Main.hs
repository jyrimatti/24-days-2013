{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Data.SBV

main :: IO ()
main = do
  a <- prove . forAll ["x"] $ \ (x::SWord8) -> x * 2 .== x + x
  print a
  b <- prove . forAll ["x"] $ \ (x::SWord8) -> x * 3 .== x + x
  print b
  c <- sat . forSome ["x", "y"] $ \ (x::SInteger) y -> x^2 + y^2 .== 25 &&& 3 * x + 4 * y .== 0
  print c
  d <- sat . forSome ["x", "y"] $ \ (x::SInteger) y -> x^2 + y^2 .== 42 &&& 3 * x + 4 * y .== 0
  print d
  e <- sat . forSome ["x", "y", "z"] $ \ (x::SInteger) y z -> x + 2 * y .== 3 * y + z + x^2 &&& x ./= y
  print e
  res <- sat . forSome ["x", "y"] $ \(x::SWord8) y -> x^2 + y .== 10 &&& y^2 + x^3 .== 100
  print (extractModel res :: Maybe (Word8, Word8))
  print (extractModel res :: Maybe [Word8])