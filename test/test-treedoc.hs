module Main (main) where

import qualified Text.Pandoc.App as P
import qualified PandocOptionsUtil as P
import qualified Treedoc as T

test1args :: [String]
test1args = [ "--tree-to=texinfo"
            , "--tree-out=/home/tassos/Software/treedoc/test/output/texinfo/out1.texi"
            , "--from=markdown"
            , "--to=texinfo"
            , "-s"
            , "/home/tassos/Software/treedoc/test/data/genericmarkup/example1" ]

test1 :: IO ()
test1 = do
  (treedocOpt, otherArgs) <- T.parseOptionsFromArgs test1args T.options T.defaultOpts
  pandocOpt <- P.parseOptionsFromArgs otherArgs P.options P.defaultOpts
  T.convertTreeWithOpts treedocOpt pandocOpt

test2args :: [String]
test2args = [ "--tree-to=genericmarkup"
            , "--tree-out=/home/tassos/Software/treedoc/test/output/genericmarkup/out1/"
            , "--from=markdown"
            , "--to=org"
            , "/home/tassos/Software/treedoc/test/data/genericmarkup/example1" ]

test2 :: IO ()
test2 = do
  (treedocOpt, otherArgs) <- T.parseOptionsFromArgs test2args T.options T.defaultOpts
  pandocOpt <- P.parseOptionsFromArgs otherArgs P.options P.defaultOpts
  T.convertTreeWithOpts treedocOpt pandocOpt

main :: IO ()
main = do
  test1
  test2
