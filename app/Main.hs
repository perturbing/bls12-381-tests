{-# LANGUAGE ImportQualifiedPost #-}

module Main where

import Cardano.Crypto.EllipticCurve.BLS12_381

import Data.ByteString qualified as BS
import Numeric qualified as N

prettyPrint :: BS.ByteString -> String
prettyPrint = concat . map (flip N.showHex "") . BS.unpack

main :: IO ()
main = do print $ prettyPrint (serialize $ mult (generator :: P Curve1) 1)
          print $ prettyPrint (serialize $ mult (generator :: P Curve2) 1)

