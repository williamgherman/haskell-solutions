## Chapter 9.

### Exercise 9.01

Redefine the combinatorial function `choices` using a list comprehension rather
than using composition, `concat` and `map`.

### Soluion

```haskell
choices :: [a] -> [[a]]
choices as = [ys | xs <- subs as, ys <- perms xs]
```

### Exercise 9.02

Define a recursive function `isChoice :: Eq => [a] -> [a] -> Bool` that decides
if one list is chosen from another, without using the combinatorial functions
`perms` and `subs`. Hint: start by defining a function that removes the first
occurrence of a value from a list.

### Solution

```haskell
rmFirst :: Eq a => a -> [a] -> [a]
rmFirst _ []                 = []
rmFirst x (a:as) | x == a    = as
                 | otherwise = a : rmFirst as

isChoice :: Eq a => [a] -> [a] -> Bool
isChoice []     _  = True
isChoice (x:xs) [] = False
isChoice (x:xs) ys = elem x ys && isChoice xs (rmFirst x ys)
```

### Exercise 9.03

What effect would generalising the function `split` to also return pairs
containing the empty list have on the behaviour of `solutions`?

### Solution

If `split` would also return empty list pairs, then the function `exprs` would
no longer be guaranteed to reduce the length of the list, and `solutions` would
run indefinitely.
