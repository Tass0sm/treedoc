module Treedoc.App.Opt
  ( Opt (..)
  , defaultOpts ) where

import Treedoc.Definition

data Opt = Opt
    { optFrom       :: TreeFormat         -- Input format
    , optTo         :: Maybe TreeFormat         -- Output format
    , optInputPath  :: Maybe FilePath -- Input File Location
    , optOutputPath :: Maybe FilePath -- Output File Location
    } deriving (Show)

defaultOpts :: Opt
defaultOpts = Opt
  { optFrom = GenericMarkup
  , optTo   = Nothing
  , optInputPath = Nothing
  , optOutputPath = Just "." }
