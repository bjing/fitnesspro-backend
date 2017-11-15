{-# LANGUAGE OverloadedStrings #-}
module Main where

import Lib
import Model
import Calculator as C

import Web.Scotty
import Web.Scotty.Internal.Types (ActionT)
import Network.HTTP.Types.Status
import Network.Wai.Metrics
import qualified System.Remote.Monitoring as EKG
import qualified System.Metrics.Counter as Counter
import qualified System.Metrics.Distribution as Distribution
import System.Remote.Monitoring (forkServer, serverMetricStore)

import Control.Concurrent
import Control.Monad.IO.Class (liftIO)
import Data.Monoid (mconcat, (<>))
import Control.Monad
import Data.Text (Text)
import Data.Aeson hiding (json)
import qualified Data.Text.Lazy as TL

main = do
  putStrLn "Starting monitoring server..."
  store <- serverMetricStore <$> forkServer "0.0.0.0" 8000
  waiMetrics <- registerWaiMetrics store

  putStrLn "Starting server..."
  scotty 3000 $ do
    middleware (metrics waiMetrics)
    router

router = do
    get "/" home
    post "/calculate-bmr" getBmr
    post "/calculate-tdee" getTdee

home :: ActionM ()
home = text "Hello! I'm alive and kicking!"

getBmr :: ActionM ()
getBmr = do
  p <- parsePayload
  case p of
    Just m -> json $ object [ "bmr" .= C.calcBmr m]
    Nothing -> status noContent204

getTdee :: ActionM ()
getTdee = do
  p <- parsePayload
  case p of
    Just m -> json $ object [ "tdee" .= C.calcTdee m]
    Nothing -> status badRequest400

parsePayload :: ActionT TL.Text IO (Maybe Measurement)
parsePayload = do
  b <- body
  return (decode b :: Maybe Measurement)
