{-# language OverloadedStrings #-}

module Main
  ( main
  )
where


import           Control.Monad.IO.Class         ( liftIO )
import qualified Network.Wai.Handler.Warp      as Warp
import           Web.Scotty                     ( body
                                                , file
                                                , get
                                                , post
                                                , raw
                                                , scottyApp
                                                )

import           Mythology.API                  ( mythologyApi )


main :: IO ()
main = do
  httpApp <- scottyApp $ do
    post "/mythology" $ raw =<< (liftIO . mythologyApi =<< body)
    get "/mythology" $ file "./index.html"
  Warp.run 3000 httpApp
