## Chapter 6.

### Exercise 6.01

How does the recursive version of the factorial function behave if applied to a
negative argument, such as `(-1)`? Modify the definition to prohibit negative
arguments by adding a guard to the recursive case.

### Solution

The function will continue forever, since `fac 0` will never be reached.

```haskell
fac :: Int -> Int
fac 0         = 1
fac n | n > 0 = n * fac (n - 1)
```

### Exercise 6.02

Define a recursive function `sumdown :: Int -> Int` that returns the sum of the
non-negative integers from a given value down to zero. For example, `sumdown 3`
should return the result `3+2+1+0 = 6`.

### Solution

```haskell
sumdown :: Int -> Int
sumdown 0 = 0
sumdown x = x + sumdown (x - 1)
```

### Exercise 6.03

Define the exponentiation operator `^` for non-negative integers using the same
pattern of recursion as the multiplication operator `*`, and show how the
expression `2 ^ 3` is evaluated using your definition.

### Solution

```haskell
(^) :: Int -> Int -> Int
_ ^ 0 = 1
x ^ y = x * (x ^ (y - 1))


2 ^ 3                   -- apply ^
2 * (2 ^ 2)             -- apply ^
2 * (2 * (2 ^ 1))       -- apply ^
2 * (2 * (2 * (2 ^ 0))) -- apply ^
2 * (2 * (2 * 1))       -- apply *
2 * (2 * 2)             -- apply *
2 * 4                   -- apply *
8
```

### Exercise 6.04

Define a recursive function `euclid :: Int -> Int -> Int` that implements
*Euclid's algorithm* for calculating the greates common divisor of two
non-negative integers: if the two numbers are equal, this number is the result;
otherwise, the smaller number is subtracted from the larger, and the same
process is repeated. For example:

```
> euclid 6 27
3
```

### Solution

```haskell
euclid :: Int -> Int -> Int
euclid x y | x == y = x
           | x >  y = euclid (x-y) y
           | x <  y = euclid x (y-x)
```

### Exercise 6.05

Using the recursive definitions given in this chapter, show how `length
[1,2,3]`, `drop 3 [1,2,3,4,5]`, and `init [1,2,3]` are evaluated.

### Solution

```haskell
length [1,2,3]          -- apply length
1 + length [2,3]
1 + 1 + length [3]
1 + 1 + 1 + length []   -- apply length base case
1 + 1 + 1 + 0           -- apply +
1 + 1 + 1
1 + 2
3

drop 3 [1,2,3,4,5]  -- apply drop
drop 2 [2,3,4,5]
drop 1 [3,4,5]
drop 0 [4,5]
[4,5]

init [1,2,3]        -- apply init
1 : init [2,3]
1 : 2 : init [3]    -- apply init base case
1 : 2 : []          -- syntactic sugar
[1,2]
```

### Exercise 6.06

Without looking at the definitions from the standard prelude, define the
following library functions on lists using recursion.

1. Decide if all logical values in a list are `True`:

        and :: [Bool] -> Bool

2. Concatenate a list of lists:

        concat :: [[a]] -> [a]

3. Produce a list with `n` identical elements:

        replicate :: Int -> a -> [a]

4. Select the `n`th element of a list:

        (!!) :: [a] -> Int -> a

5. Decide if a value is an element of a list:

        elem :: Eq a => a -> [a] -> Bool

Note: most of these functions are defined in the prelude using other library
functions rather than using explicit recursion, and are generic functions rather
than being specific to the type of lists.

### Solution

```haskell
and :: [Bool] -> Bool
and [b] = b
and (b:bs) | b == False = False
           | otherwise  = and bs

concat :: [[a]] -> [a]
concat [a]    = a
concat (a:as) = a ++ concat as

replicate :: Int -> a -> [a]
replicate 0 _ = []
replicate n a = a : replicate (n-1) a

(!!) :: [a] -> Int -> a
(a:_)  !! 0 = a
(_:as) !! n = as !! (n-1)

elem :: Eq a => a -> [a] -> Bool
elem _ [] = False
elem n (a:as) | n == a    = True
              | otherwise = elem n as
```

### Exercise 6.07

Define a recursive function `merge :: Ord a => [a] -> [a] -> [a]` that merges
two sorted lists to give a single sorted list. For example:

```
> merge [2,5,6] [1,3,4]
[1,2,3,4,5,6]
```

Note: your definition should not use other functions on sorted list such as
`insert` or `isort`, but should be defined using explicit recursion.

### Solution

```haskell
merge :: Ord a => [a] -> [a] -> [a]
merge as [] = as
merge [] bs = bs
merge (a:as) (b:bs) | a <= b    = a : merge as (b:bs)
                    | otherwise = b : merge (a:as) bs
```

### Exercise 6.08

Using `merge`, define a function `msort :: Ord a => [a] -> [a]` that implements
*merge sort*, in which the empty list and singleton lists are already sorted,
and any other list is sorted by merging together the two lists that result from
sorting the two halves of the list separately.

Hint: first define a function `halve :: [a] -> ([a],[a])` that splits a list
into two halves whose lengths differ by ay most one.

### Solution

```haskell
halve :: [a] -> ([a],[a])
halve as = (take half as, drop half as)
           where half = length as `div` 2

msort :: Ord a => [a] -> [a]
msort [] = []
msort [a] = [a]
msort as = merge (msort left) (msort right)
           where (left, right) = halve as
```

### Exercise 6.09

Using the five-step process, construct the library functions that:

1. calculate the `sum` of a list of numbers;
2. `take` a given number of elements from the start of a list;
3. select the `last` element of a non-empty list.

### Solution

```haskell
sum :: Num a => [a] -> a
sum [] = 0
sum (x:xs) = x + sum xs

take :: Int -> [a] -> [a]
take 0 _ = []
take _ [] = []
take n (x:xs) = x : take (n-1) xs

last :: [a] -> a
last [a] = a
last (_:as) = last as
```
