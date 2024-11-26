import Math.NumberTheory.Roots
import Data.Binary

main :: IO ()
main = do
    contents <- readFile "ciphertext"
    let list = [ [ c | c <- line, c `elem` ['0'..'9']] | line <- lines contents ]
    let nums = [ read x :: Integer | x <- list]

    let n = head nums :: Integer
    let c = last nums :: Integer

    let s = put (65 :: Integer)

    print (getRoots n c)

getRoots :: Integral a => a -> a -> [a]
getRoots n c = [ integerCubeRoot (c + k*n) | k <- [1..10]]
