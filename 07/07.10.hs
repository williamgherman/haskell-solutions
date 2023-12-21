altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ []       = []
altMap f _ [x]      = [f x]
altMap f g (x:y:ys) = f x : g y : altMap f g ys

luhnDouble :: Int -> Int
luhnDouble x | n > 9     = n - 9
             | otherwise = n
             where n = x * 2

luhn :: [Int] -> Bool
luhn xs = total `mod` 10 == 0
          where total = sum (altMap id luhnDouble (reverse xs))
