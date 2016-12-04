{-# LANGUAGE DeriveFunctor #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}
module Main where

import Prelude hiding (log)
import Control.Eff
import Control.Eff.Lift
import Data.Typeable (Typeable)

main :: IO ()
main = do
  putStrLn "With a pure effect:"
  print $ run $ runLogger verboseAddition

  putStrLn ""
  
  putStrLn "With an impure (IO) effect:"
  _ <- runLift $ runIOLogger verboseAddition 
  return ()

data Log v = Log String v deriving (Functor, Typeable)

log :: Member Log r => String -> Eff r ()
log txt = send . inj $ Log txt ()

verboseAddition :: Member Log r => Eff r Int
verboseAddition = do
  log "I'm starting with 1..."
  x <- return 1

  log "and I'm adding 2..."
  y <- return 2

  let r = x + y

  log $ "Looks like the result is " ++ show r
  return r

runLogger :: Eff (Log :> r) a -> Eff r (a, [String])
runLogger = freeMap 
              (\v -> return (v, []))
              (\u -> handleRelay u runLogger (\(Log txt k) -> prefixLogWith txt <$> runLogger k))
            where prefixLogWith txt (v, l) = (v, txt:l)

runIOLogger :: SetMember Lift (Lift IO) r => Eff (Log :> r) a -> Eff r a
runIOLogger = freeMap 
                return
                (\u -> handleRelay u runIOLogger (\(Log txt k) -> lift (putStrLn txt) >> runIOLogger k))
