module Calculator where

import Model

import Control.Monad
import Data.Map

calcBmr :: Measurement -> Double
calcBmr m = calcBmr' (gender m) (height m) (weight m) (age m)

calcBmr' :: Gender -> Double -> Double -> Double -> Double
calcBmr' Male height weight age = 10 * weight + 6.25 * height - 5 * age + 5
calcBmr' Female height weight age = 10 * weight + 6.25 * height - 5 * age - 161

calcTdee :: Measurement -> Maybe Double
calcTdee m = calcTdee' (exerciseLevel m) (calcBmr m)

calcTdee' :: Maybe ExerciseLevel -> Double -> Maybe Double
calcTdee' exerciseLevel bmr =
  exerciseLevel >>= \el ->
    (*bmr) <$> Data.Map.lookup el tdeeLevels
