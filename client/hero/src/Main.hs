{-# LANGUAGE OverloadedStrings #-}

module Main
  ( main
  )
where

import           Data.Morpheus                  ( Interpreter(..) )

import           Hero                           ( fetchHero )


main :: IO ()
main = fetchHero >>= print
