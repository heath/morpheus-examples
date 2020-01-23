{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Hero
  ( fetchHero
  )
where

import           Data.ByteString.Lazy.Char8     ( ByteString )
import           Data.Morpheus.Client           ( Fetch(..)
                                                , defineByDocumentFile
                                                , gql
                                                )
import           Data.Morpheus.Types            ( ScalarValue(..) )
import           Data.Text                      ( Text )

defineByDocumentFile
  "./assets/simple.gql"
  [gql|
    # Query Hero with Compile time Validation
    query GetHero ($god: Realm, $someID: String!)
      {
        deity (mythology:$god) {
          power
          fullName
        }
        character(characterID: $someID ) {
          ...on Creature {
            name
            immortality
          }
          ...on Human {
            lifetime
            profession
          }
        }
        char2: character(characterID: $someID ) {
          ...on Creature {
              cName: name
          }
          ...on Human {
              lTime: lifetime
              prof: profession
          }
        }
      }
  |]

ioRes :: ByteString -> IO ByteString
ioRes req = do
  print req
  return
    "{\"data\":{\"deity\":{ \"fullName\": \"name\" }, \"character\":{ \"__typename\":\"Human\", \"lifetime\": \"Lifetime\", \"profession\": \"Artist\" } ,  \"char2\":{ \"__typename\":\"Human\", \"lTime\": \"time\", \"prof\": \"Artist\" }  }}"

fetchHero :: IO (Either String GetHero)
fetchHero = fetch
  ioRes
  GetHeroArgs
    { getHeroArgsGod    = Just Realm { realmOwner      = "Zeus"
                                     , realmAge        = Just 10
                                     , realmRealm      = Nothing
                                     , realmProfession = Just Artist
                                     }
    , getHeroArgsSomeID = "Hercules"
    }
