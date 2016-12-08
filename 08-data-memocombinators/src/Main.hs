module Main where

import qualified Data.MemoCombinators as Memo
import Control.Monad.Memo
import System.TimeIt

main = do
    timeIt $ putStrLn $ "fibFast    42000: " ++ (show $ fibFast 42000)
    timeIt $ putStrLn $ "fibm       42000: " ++ (show $ startEvalMemo $ fibm 42000)
    timeIt $ putStrLn $ "fibLucky   14200: " ++ (show $ fibLucky 14200)
    timeIt $ putStrLn $ "fibUnlucky 14200: " ++ (show $ fibUnlucky 14200)
    timeIt $ putStrLn $ "fib           42: " ++ (show $ fib 42)

--fib :: Int -> Int
fib 0 = 1
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fibLucky = (map fib' [0..] !!)                 
     where fib' 1 = 1                                                        
           fib' 2 = 1                                                        
           fib' n = fibLucky (n-2) + fibLucky (n-1)

fibUnlucky n = (map fib' [0..] !! n)                                               
     where fib' 1 = 1                                                        
           fib' 2 = 1                                                        
           fib' n = fibUnlucky (n-2) + fibUnlucky (n-1)    

--fibFast :: Int -> Int
fibFast = Memo.integral fib'
 where fib' 0 = 1
       fib' 1 = 1
       fib' n = fibFast (n - 1) + fibFast (n - 2)

-- I guess it's a matter of definition...
--fibm 0 = return 0
fibm 0 = return 1
fibm 1 = return 1
fibm n = do
  n1 <- memo fibm (n-1)
  n2 <- memo fibm (n-2)
  return (n1+n2)