module Main where

import           Test.Tasty
import           Test.Tasty.Hspec
import           Test.Tasty.HUnit
import           Test.Tasty.Program
import           Test.Tasty.Runners.AntXML (antXMLRunner)
import           Test.Tasty.SmallCheck

import           Control.Monad             (join)
import           Data.List

main :: IO ()
-- becomes IO (IO a) due to sequencing, so need to 'join'.
-- This is waaaaay too complicated...
main = join $ defaultMainWithIngredients (antXMLRunner : defaultIngredients) <$>
    testGroup "Tests" <$> sequence
    [ return $ testGroup "(checked by SmallCheck)"
        [ testProperty "sort == sort . reverse" $
            \list -> sort (list :: [Int]) == sort (reverse list)

        , testProperty "Fermat's last theorem" $
            \x y z n -> (n :: Integer) >= 3 ==>
             x^n + y^n /= (z^n :: Integer)
        ]

    , return $ testGroup "Unit tests"
        [ testCase "List comparison (different length)" $
            [1, 2, 3] `compare` [1,2] @?= GT

        , testCase "List comparison (same length)" $
            [1, 2, 3] `compare` [1,2,2] @?= LT
        ]

    -- testSpec returns a monad, so need to sequence the monad "out" and 'return' all other test in the List
    , testGroup "HSpec tests" <$> sequence
        [ testSpec "my specification" $
            describe "Prelude.head" $
                it "returns the first element of a list" $
                    head [23 ..] `shouldBe` (23 :: Int)
        ]

    , return $ testGroup "External tests"
        [ testProgram "program returns successfully" "sh" ["someProg.sh"] Nothing]
    ]
