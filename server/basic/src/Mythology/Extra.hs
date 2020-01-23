{-# LANGUAGE DataKinds             #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE DerivingStrategies    #-}
{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE FlexibleContexts      #-}
{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE NamedFieldPuns        #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE ScopedTypeVariables   #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}

-- TODO remove the above and figure out which of these isn't needed

module Mythology.Extra
  ( gqlRoot
  , EVENT
  )
where

import           Data.Morpheus.Types            ( Event(..) )

data Channel = USER | ADDRESS deriving (Show, Eq, Ord)

newtype Content = Content { contentID :: Int }

type EVENT = (Event Channel Content)

