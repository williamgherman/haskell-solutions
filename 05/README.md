## Chapter 5.

### Exercise 5.01

Using a list comprehension, give an expression that calculates the sum
1<sup>2</sup> + 2<sup>2</sup> + ... 100<sup>2</sup> of the first one hundred
integer squares.

### Solution

```haskell
sum [x^2 | [1..100]
```

### Exercise 5.02

Suppose that a *coordinate grid* of size *m* &times; *n* is given by the list of
all pairs (*x*, *y*) of integers such that 0 &le; *x* &le; *m* and 0 &le; *y*
&le; *n*. Using a list comprehension, define a function `grid :: Int -> Int ->
[(Int,Int)]` that returns a coordinate grid of a given size. For example:

```
> grid 1 2
[(0,0),(0,1),(0,2),(1,0),(1,1),(1,2)]
```

### Solution

```haskell
grid :: Int -> Int -> [(Int,Int)]
grid m n = [(x,y) | x <- [0..m], y <- [0..n]]
```

### Exercise 5.03

Using a list comprehension and the function `grid` above, define a function
`square :: Int -> [(Int, Int)]` that returns a coordinate square of size *n*,
excluding the diagonal from (0, 0) to (*n*, *n*). For example:

```
> square 2
[(0,1),(0,2),(1,0),(1,2),(2,0),(2,1)]
```

### Solution

```haskell
square :: Int -> [(Int,Int)]
square n = [(x,y) | (x,y) <- grid n n, x \= y]
```

### Exercise 5.04

In a similar way to the function `length`, show how the library function
`replicate :: Int -> a -> [a]` that produces a list of identical elements can be
defined using a list comprehension. For example:

```
> replicate 3 True
[True,True,True]
```

### Solution

```haskell
replicate :: Int -> a -> [a]
replicate x a = [a | _ <- [0..x]]
```

### Exercise 5.05

A triple (*x, *y*, *z*) of positive integers is *Pythagorean* if it satisfies
the equation *x*<sup>2</sup> + *y*<sup>2</sup> = *z*<sup>2</sup>. Using a list
comprehension with three generators, define a function `pyths :: Int ->
[(Int,Int,Int)]` that returns the list of all such triples whose components are
at most a given limit. For example:

```
pyths 10
[(3,4,5),(4,3,5),(6,8,10),(8,6,10)]
```

### Solution

```haskell
pyths :: Int -> [(Int,Int,Int)]
pyths n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]
```

### Exercise 5.06

A positive integer is *perfect* if it equals the sum of all of its factors,
excluding the number itself. Using a list comprehension and the function
`factors`, define a function `perfects :: Int -> [Int]` that returns the list of
all perfect numbers up to a given limit. For example:

```
> perfects 500
[6,28,496]
```

### Solution

```haskell
perfects :: Int -> [Int]
perfects n = [x | x <- [1..n], sum (init (factors x)) == x]
```

### Exercise 5.07

Show how the list comprehension `[(x,y) | x <- [1,2], y <- [3,4]]` with two
generators can be re-expressed using two comprehensions with single generators.
Hint: nest one comprehension within the other and make use of the library
function `concat :: [[a]] -> [a]`.

### Solution

```haskell
concat [[(x,y) | y <- [3,4]] | x <- [1,2]]
```

### Exercise 5.08

Redefine the function `positions` using the function `find`.

### Solution

```haskell
-- find, copied from section 5.2:
find :: Eq a => a -> [(a,b)] -> [b]
find k t = [v | (k',v) <- t, k == k']

positions :: Eq a => a -> [a] -> [Int]
positions x xs = find x [(k,v) | k <- xs, v <- [0..]]

-- or, more succinctly:
positions x xs = find x (zip xs [0..])
```

### Exercise 5.09

The *scalar product* of two lists of inteers *x*s and *y*s of length *n* is
given by the sum of the products of corresponding integers:

(Sum from *i* = 0 to *i* = *n* - 1 of (*xs*<sub>*i*</sub> \*
*ys*<sub>*i*</sub>))

In a similar manner to `chisqr`, show how a list comprehension can be used to
define a function `scalarproduct :: [Int] -> [Int] -> Int` that returns the
scalar product of two lists. For example:

```
> scalarproduct [1,2,3] [4,5,6]
32
```

### Solution

```haskell
scalarproduct :: [Int] -> [Int] -> Int
scalarproduct xs ys = sum [x * y | (x,y) <- zip xs ys]
```

### Exercise 5.10

Modify the Caesar cipher program to also handle upper-case letters.

### Solution

A quick and dirty solution would be to forcably convert all letters to
lower-case:

```haskell
shift :: Int -> Char -> Char
shift n c | isLetter c = int2let ((let2int (toLower c) + n) `mod` 26)
          | otherwise = c
```

Otherwise, you could explicitly allow upper-case letters to be dealt with in a
new function, `int2letUpper`:

```haskell
shift :: Int -> Char -> Char
shift n c | isLower c = int2let ((let2int c + n) `mod` 26)
          | isUpper c = int2letUpper ((let2int c + n) `mod` 26)
          | otherwise = c

int2letUpper :: Int -> Char
int2letUpper n = chr (ord 'A' + n)
```

To get the `crack` program working correctly, we would simply convert the string
to all lower-case:

```haskell
crack :: String -> String
crack xs = encode (-factor) xs
    where
        factor = head (positions (minimum chitab) chitab)
        chitab = [chisqr (rotate n table') table | n <- [0..25]]
        table' = freqs [toLower x | x <- xs]
        -- or, using material not yet fully introduced, the map function:
        table' = freqs (map toLower xs)
```
