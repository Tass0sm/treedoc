{-# LANGUAGE OverloadedStrings #-}

module Treedoc.Formats.Texinfo
  ( readIntoTree_TI
  , convertTree_TI
  , writeFromTree_TI ) where

import qualified Text.Pandoc.Builder as P
import qualified Text.Pandoc.App as P
import qualified Data.Text as T

import Text.Pandoc

import Data.Tree

import Treedoc.Definition
import Treedoc.TreeUtil
import Treedoc.Util

-- Impure Code:
--- Reading:

unfolder :: FilePath -> IO (DocNode, [FilePath])
unfolder path = undefined

readIntoTree_TI :: FilePath -> IO (DocTree)
readIntoTree_TI path = do
  tree <- (unfoldTreeM_BF unfolder) path
  return (Texinfo, tree)

--- Conversion:

convertLeaf :: P.Opt -> DocNode -> IO DocNode
convertLeaf opt (name, format, text) = do
  newText <- translateMarkupWithPandoc text opt
  return (name, Just "texinfo", newText)
  
convertInner :: P.Opt -> DocNode -> IO DocNode
convertInner opt (name, format, text) = do
  let pandoc = P.doc $ P.header 1 (P.text $ T.pack name)
  result <- runIO $ do
    writeTexinfo def pandoc
  texinfo <- handleError result
  return (name, Just "texinfo", texinfo)
    
convertNode :: P.Opt -> Bool -> DocNode -> IO DocNode
convertNode opt isLeaf inputNode =
  if isLeaf
  then convertLeaf opt inputNode
  else convertInner opt inputNode

convertTree_TI :: P.Opt -> DocTree -> IO DocTree
convertTree_TI opt (_, nodeTree) =
  let converter = convertNode opt
  in do
    newTree <- traverseWithLeafCondition converter nodeTree
    return (Texinfo, newTree)
     
--- Writing:
  
writeNode :: DocNode -> FilePath -> IO ()
writeNode (_, _, text) outputPath =
  appendFile outputPath (T.unpack text)

writeFromTree_TI :: DocTree -> FilePath -> IO ()
writeFromTree_TI (_, nodeTree) outputPath =
  let writer = (\input -> writeNode input outputPath)
  in foldMap writer (flatten nodeTree)
