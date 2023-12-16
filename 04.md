## Chapter 4.

### Exercise 4.01

Using library functions, define a function `halve :: [a] -> ([a],[a])` that
splits an even-lengthed list into two halves. For example:

```
> halve [1,2,3,4,5,6]
([1,2,3],[4,5,6])
```

### Solution

```haskell
halve :: [a] -> ([a],[a])
halve xs = (take half xs, drop half xs)
           where half = length xs `div` 2
```

### Exercise 4.02

Define a function `third :: [a] -> a` that returns the third element in a list
that contains at least this many elements using:

1. `head` and `tail`;
2. list indexing `!!`;
3. pattern matching.

### Solution

```haskell
third :: [a] -> a
third xs = head (tail (tail xs))

third xs = xs !! 2

third (_:_:x:_) = x
```

### Exercise 4.03

Consider a function `safetail :: [a] -> [a]` that behaves in the same way as
`tail` except that it maps the empty list to itself rather than producing an
error. Using `tail` and the function `null :: [a] -> Bool` that decides if a
list is empty or not, define `safetail` using:

1. a conditional expression;
2. guarded equations;
3. pattern matching.

### Solution

```haskell
safetail :: [a] -> [a]
safetail xs = if null xs then [] else tail xs

safetail xs | null xs   = []
            | otherwise = tail xs

safetail [] = []
safetail xs = tail xs
-- or: safetail (_:xs) = xs
```

### Exercise 4.04

In a similar way to `&&` in section 4.4, show how the disjunction operator `||`
can be defined in four different ways using pattern matching.

### Solution

```haskell
(||) :: Bool -> Bool -> Bool
True  || True  = True
True  || False = True
False || True  = True
False || False = False

False || False = False
_     || _     = False

False || b = b
True  || _ = True

b || c | b == c    = b
       | otherwise = True
```

### Exercise 4.05

Without using any other library functions or operators, show how the meaning of
the following pattern matching definition for logical conjunction `&&` can be
formalised using conditional expressions:

```haskell
True && True = True
_    && _    = False
```

Hint: use two nested conditional expressions.

### Solution

```haskell
a && b = if a == True
         then if b == True
              then True
              else False
         else False
```

### Exercise 4.06

Do the same for the following alternative definition, and note the difference in
the number of conditional expressions that are required:

```haskell
True  && b = b
False && _ = False
```

### Solution

```haskell
a && b = if a == True then b else False
```

### Exercise 4.07

Show how the meaning of the following curried function definition can be
formalised in terms of lambda expressions:

```haskell
mult :: Int -> Int -> Int -> Int
mult x y z = x*y*z
```

### Solution

```haskell
mult :: Int -> (Int -> (Int -> Int))
mult = \x -> (\y -> (\z -> x*y*z))
```

### Exercise 4.08

The *Luhn algorithm* is used to check bank card numbers for simple errors such
as mistyping a digit, and proceeds as follows:

* consider each digit as a separate number;
* moving left, double every other number from the second last;
* subtract 9 from each number that is now greater than 9;
* add all the resulting numbers together;
* if the total is divisible by 10, the card is valid.

Define a function `luhnDouble :: Int -> Int` that doubles a digit and subtracts
`9` if the result is greater than `9`. For example:

```
> luhnDouble 3
6

> luhnDouble 6
3
```

Using `luhnDouble` and the integer remainder function `mod`, define a function
`luhn :: Int -> Int -> Int -> Int -> Bool` that decides if a four-digit bank
card number is valid. For example:

```
> luhn 1 7 8 4
True

> luhn 4 7 8 3
False
```

In the exercises in chapter 7 we will consider a more general version of this
function that accepts card numbers of any length.

### Solution

```haskell
luhnDouble :: Int -> Int
luhnDouble x | n > 9     = n - 9
             | otherwise = n
             where n = x * 2

luhn :: Int -> Int -> Int -> Int -> Bool
luhn w x y z = total `mod` 10 == 0
               where total = z + luhnDouble y + x + luhnDouble w
```
