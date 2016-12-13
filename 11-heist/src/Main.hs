{-# LANGUAGE OverloadedStrings #-}
module Main where

import Blaze.ByteString.Builder (toByteString)
import qualified Data.ByteString.Char8 as BS
import Control.Monad.IO.Class (MonadIO(..))
import Control.Monad.Trans.Either
import Control.Monad.Trans.Class (lift)
import Data.Monoid (mempty)
import Data.Foldable (forM_)
import Data.Map.Syntax ((##))
import Heist
import Heist.Interpreted
import Text.XmlHtml (Node(TextNode), renderHtmlFragment, Encoding(UTF8))
import Control.Lens ((&),(.~))

main = do
  billy
  names
  summary

billy :: IO ()
billy = eitherT (putStrLn . unlines) return $ do
  heist <- lift $ initHeist $ emptyHeistConfig
    & hcTemplateLocations .~ [ loadTemplates "templates" ]
    & hcInterpretedSplices .~ defaultInterpretedSplices
    & hcNamespace .~ ""
  foo <- hoistEither heist

  Just (output, _) <- renderTemplate foo "billy" 

  liftIO . BS.putStrLn . toByteString $ output


names :: IO ()
names = eitherT (putStrLn . unlines) return $ do
  heist <- lift $ initHeist $ emptyHeistConfig
    & hcTemplateLocations .~ [ loadTemplates "templates" ]
    & hcInterpretedSplices .~ defaultInterpretedSplices
    & hcNamespace .~ ""
  foo <- hoistEither heist

  names <- liftIO getNames

  forM_ names $ \name -> do
    Just (output, _) <- renderTemplate
      (bindSplice "kiddo" (textSplice name) foo)
      "merry-christmas"

    liftIO . BS.putStrLn . toByteString $ output


getNames = return [ "Tom", "Dick", "Harry" ]


summary :: IO ()
summary = eitherT (putStrLn . unlines) return $ do
  heist <- lift $ initHeist $ emptyHeistConfig
    & hcTemplateLocations .~ [ loadTemplates "templates" ]
    & hcInterpretedSplices .~ defaultInterpretedSplices
    & hcNamespace .~ ""
  foo <- hoistEither heist

  Just (output, _) <- renderTemplate
    (bindSplice "names" namesSplice foo)
    "summary"

  liftIO . BS.putStrLn . toByteString $ output


namesSplice =
  liftIO getNames >>=
    mapSplices (\name -> runChildrenWithText ("name" ##  name))
