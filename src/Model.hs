{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

module Model where

import GHC.Generics
import Data.Aeson
import Data.Map
import Data.Map.Lazy

data Gender = Male | Female deriving (Show, Generic)

instance FromJSON Gender
instance ToJSON Gender

data Measurement = Measurement {
  gender :: Gender
, height :: Double
, weight :: Double
, age :: Double
, exerciseLevel :: Maybe ExerciseLevel
} deriving (Show, Generic)

instance FromJSON Measurement where
  parseJSON (Object v) =
    Measurement <$> v .: "gender"
                <*> v .: "height"
                <*> v .: "weight"
                <*> v .: "age"
                <*> v .:? "exerciseLevel"
instance ToJSON Measurement

data ExerciseLevel = NoExercise
  | LightExercise
  | ModerateExercise
  | HeavyExercise
  | VeryHeavyExercise
  deriving (Ord, Eq, Show, Generic)

instance FromJSON ExerciseLevel
instance ToJSON ExerciseLevel

tdeeLevels :: Map ExerciseLevel Double
tdeeLevels = Data.Map.Lazy.fromList [
    (NoExercise, 1.2)
  , (LightExercise, 1.375)
  , (ModerateExercise, 1.55)
  , (HeavyExercise, 1.725)
  , (VeryHeavyExercise, 1.9)
  ]

-- TODO add validator for numbers
-- validateNumber :: Double -> Either String Double
-- validateNumber h
--   | h > 0 = Right h
--   | otherwise = Left "Numbers should be greater than 0"

-- validateMeasurement :: Measurement -> Either String Measurement
-- validateMeasurement m = do
--   height <- validateNumber $ height m
--   weight <- validateNumber $ weight m
--   age <- validateNumber $ age m
--   return Measurement (gender m) height weight age (exerciseLevel m)