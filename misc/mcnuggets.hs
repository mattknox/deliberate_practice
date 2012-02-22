import Data.List

notMcNuggets :: [Integer]
notMcNuggets = [1..180] \\
    [a+b+c | a <- [0,6..180], b <- [0,9..180-a], c <- [0,20..180-a-b]]

