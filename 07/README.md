## Chapter 7.

### Exercise 7.01

Show how the list comprehension `[f x | x <- xs, p x]` can be re-expressed using
the higher-order functions `map` and `filter`.

### Solution

```haskell
map f (filter p xs)
```

### Exercise 7.02

Without looking at the definitions from the standard prelude, define the
following higher-order library functions on lists.

1. Decide if all elements of a list satisfy a predicate:

        all :: (a -> Bool) -> [Bool] -> Bool

2. Decide if any element of a list satisfies a predicate:

        any :: (a -> Bool) -> [Bool] -> Bool

3. Select elements from a list while they satisfy a predicate:

        takeWhile :: (a -> Bool) -> [a] -> [a]

4. Remove elements from a list while they satisfy a predicate:

        dropWhile :: (a -> Bool) -> [a] -> [a]

Note: in the prelude the first two of these functions are generic functions
rather than being specific to the type of lists.

### Solution

```haskell
all :: (a -> Bool) -> [Bool] -> Bool
all p = and . (map p)

any :: (a -> Bool) -> [Bool] -> Bool
any p = or . (map p)

takeWhile :: (a -> Bool) -> [a] -> [a]
takeWhile _ [] = []
takeWhile p (a:as)
    | p a       = a : takeWhile p as
    | otherwise = []

dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile _ [] = []
dropWhile p (a:as)
    | p a = dropWhile p as
    | otherwise = a:as
```

### Exercise 7.03

Redefine the functions `map f` and `filter p` using `foldr`.

### Solution

```haskell
map :: (a -> b) -> [a] -> [b]
map f = foldr (\x xs -> f x : xs) []

filter :: (a -> Bool) -> [a] -> [a]
filter p = foldr (\x xs -> if p x then x:xs else xs) []
```
### Exercise 7.04

Using `foldl`, define a function `dec2int :: [Int] -> Int` that converts a
decimal number into an integer. For example:

```
> dec2int [2,3,4,5]
2345
```

### Solution

```haskell
dec2int :: [Int] -> Int
dec2int as = foldl (\x y -> x * 10 + y) 0
```

### Exercise 7.05

Without looking at the definitions from the standard prelude, define the
higher-order library function `curry` that converts a function on pairs into a
curried function, and, conversely, the function `uncurry` that converts a
curried function with two arguments into a function on pairs.

Hint: first write down the types of the two functions.

### Solution

```haskell
curry :: ((a,b) -> c) -> (a -> b -> c)
curry f = \x y -> f (x,y)

uncurry :: (a -> b -> c) -> ((a,b) -> c)
uncurry f = \(x,y) -> f x y
```

### Exercise 7.06

A higher-order function `unfold` that encapsulates a simple pattern of recursion
for producing a list can be defined as follows:

```haskell
unfold p h t x | p x       = []
               | otherwise = h x : unfold p h t (t x)
```

That is, the function `unfold p h t` produces the empty list if the predicate
`p` is true of the argument value, and otherwise produces a non-empty list by
applying the function `h` to this value to give the head, and the function `t`
to generate another argument that is recursively processed in the same way to
produce the tail of the list. For example, the function `int2bin` can be
rewritten more compactly using `unfold` as follows:

```haskell
int2bin = unfold (== 0) (`mod` 2) (`div` 2)
```

Redefine the functions `chop8`, `map f` and `iterate f` using `unfold`.

### Solution

```haskell
type Bit = Int

chop8 :: [Bit] -> [[Bit]]
chop8 = unfold null (take 8) (drop 8)

map :: (a -> b) -> [a] -> [b]
map f = unfold null (f . head) tail

iterate :: (a -> a) -> a -> [a]
iterate f = unfold (\_ -> False) f f
```
### Exercise 7.07

Modify the binary string transmitter example to detect simple transmission
errors using the concept of parity bits. That is, each eight-bit binary number
produced during encoding is extended with a parity bit, set to one if the number
contains an odd number of ones, and to zero otherwise. In turn, each resulting
nine-bit binary number consumed during decoding is checked to ensure that its
parity bit is correct, with the parity bit being discarded if this is the case,
and a parity error being reported otherwise.

Hint: the library function `error :: String -> a` displays the given string as
an error message and terminates the program; the polymorphic result type ensures
that `error` can be used in any context.

### Solution

See [07.07.hs](./07.07.hs) for the full program.

### Exercise 7.08

Test your new string transmitter program from the previous exercise using a
faulty communication channel that forgets the first bit, which can be modelled
using the `tail` function on lists of bits.

### Solution

See [07.08.hs](./07.08.hs) for the program with the modified `channel` function:

```haskell
channel :: [Bit] -> [Bit]
channel = tail
```

As it is currently, the `transmit` function only correctly produces the parity
error *sometimes* (every other character: `a`, `c`, etc.) and when it does not
throw the error, it decodes the wrong result because of the missing bits.

### Exercise 7.09

Define a function `altMap :: (a -> b) -> (a -> b) -> [a] -> [b]` that
alternately applies its two argument functions to successive elements in a list,
in turn about order. For example:

```
> altMap (+10) (+100) [0,1,2,3,4]
[10,101,12,103,14]
```

### Solution

```haskell
altMap :: (a -> b) -> (a -> b) -> [a] -> [b]
altMap _ _ []       = []
altMap f _ [x]      = [f x]
altMap f g (x:y:ys) = f x : g y : altMap f g ys
```

### Exercise 7.10

Using `altMap`, define a function `luhn :: [Int] -> Bool` that implements the
*Luhn algorithm* from the exercises in [chapter 4](./04.md) for bank card
numbers of any length. Test your new function using your own bank card.

See [07.10.hs](./07.10.hs) for the complete code.
