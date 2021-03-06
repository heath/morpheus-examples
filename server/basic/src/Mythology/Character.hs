{-# LANGUAGE DeriveAnyClass        #-}
{-# LANGUAGE DeriveGeneric         #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE TypeOperators         #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns        #-}

module Mythology.Character
  ( Deity(..)
  , dbDeity
  , Human(..)
  , someHuman
  , someDeity
  )
where

import           Data.Morpheus.Types            ( GQLType(..) )
import           Data.Text                      ( Text )
import           GHC.Generics                   ( Generic )
import           Mythology.Place                ( Realm(..)
                                                , City(..)
                                                )

data Deity = Deity
  { name :: Text -- Non-Nullable Field
  , power    :: Maybe Text -- Nullable Field
  , realm    :: Realm
  , bornAt   :: Maybe City
  } deriving (Generic,GQLType)


data Human = Human
  { name :: Text
  , bornAt :: City
  } deriving (Generic,GQLType)


someHuman :: Human
someHuman = Human { name = "Odysseus", bornAt = Ithaca }

someDeity :: Deity
someDeity = Deity { name   = "Morpheus"
                  , power  = Just "Shapeshifting"
                  , realm  = Dream
                  , bornAt = Nothing
                  }

dbDeity :: Text -> Maybe City -> IO (Either String Deity)
dbDeity _ bornAt = return $ Right $ Deity { name   = "Morpheus"
                                          , power  = Just "Shapeshifting"
                                          , realm  = Dream
                                          , bornAt
                                          }
