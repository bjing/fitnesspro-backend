module CalculatorSpec (spec) where

import Model
import Calculator
import Test.Hspec

sampleMaleMeasurement = Measurement Male 175 74 30 (Just ModerateExercise)
sampleFemaleMeasurement = Measurement Female 168 60 28 (Just LightExercise)

-- TODO test invalid cases
spec :: Spec
spec = do
  describe "CalculateBMR" $ do
    it "should calculate BMR for a given male individual" $
      calcBmr sampleMaleMeasurement `shouldBe` 1688.75
    it "should calculate BMR for a given female individual" $
      calcBmr sampleFemaleMeasurement `shouldBe` 1349.0

  describe "CalculateTDEE" $ do
    it "should calculate TDEE for a given male individual" $
      calcTdee sampleMaleMeasurement `shouldBe` Just 2617.5625
    it "should calculate TDEE for a given female individual" $
      calcTdee sampleFemaleMeasurement `shouldBe` Just 1854.875
