## Chapter 3.

### Exercise 3.01

What are the types of the following values?

```
['a', 'b', 'c']
('a', 'b', 'c')
[(False, '0'), (True, '1')]
([False, True], ['0', '1'])
[tail, init, reverse]
```

### Solution

```haskell
['a', 'b', 'c']             :: [Char] -- or String
('a', 'b', 'c')             :: (Char, Char, Char)
[(False, '0'), (True, '1')] :: [(Bool, Char)]
([False, True], ['0', '1']) :: ([Bool], [Char]) -- or ([Bool], String)
[tail, init, reverse]       :: [[a] -> [a]]
```

### Exercise 3.02

Write down definitions that have the following types; it does not matter what
the definitions actually do as long as they are type correct.

```haskell
bools :: [Bool]
nums :: [[Int]]
add :: Int -> Int -> Int -> Int
copy :: a -> (a,a)
apply :: (a -> b) -> a -> b
```

### Solution

```haskell
bools :: [Bool]
bools = [True]

nums :: [[Int]]
nums = [[1]]

add :: Int -> Int -> Int -> Int
add x y z = x + y + z

copy :: a -> (a,a)
copy x = (x,x)

apply :: (a -> b) -> a -> b
apply f a = f a
```
### Exercise 3.03

What are the types of the following functions?

```haskell
second xs = head (tail xs)
swap (x,y) = (y,x)
pair x y = (x,y)
double x = x*2
palindrome xs = reverse xs == xs
twice f x = f (f x)
```

Hint: take care to include the necessary class constraints in the types if the
functions are defined using overloaded operators.

### Solution

```haskell
second :: [a] -> [a]
second xs = head (tail xs)

swap :: (a,b) -> (b,a)
swap (x,y) = (y,x)

pair :: a -> b -> (a,b)
pair x y = (x,y)

double :: Num a => a -> a
double x = x*2

palindrome :: Eq a => [a] -> Bool
palindrome xs = reverse xs == xs

twice :: (a -> a) -> a -> a
twice f x = f (f x)
```

### Exercise 3.04

Check your answers to the preceding three questions using GHCi.

### Solution

One difference GHCi will show is the type of the `add` function being of type
`Num a => a -> a -> a -> a` instead of `Int`s in Exercise 3.02. To get exactly
`Int`s, one way is to use a function that forcable constrains the type to ints
within the `add` function. For example, `length` from the standard prelude
returns an `Int`. Adding three numbers to the result will create the exact
signature:

```haskell
add' :: Int -> Int -> Int -> Int
add' x y z = length [] + x + y + z
```

### Exercise 3.05

Why is it not feasible in general for function types to be instances of the `Eq`
class? When is it feasible? Hint: two functions of the same type are equal if
they always return equal results for equal arguments.

### Solution

Two functions returning the same result for the same arguments are generally not
needed, since they both do the same thing. Perhaps it would be feasible to have
two similar functions defined for speed/efficiency/clarity reasons, like an
exponentially-recursive fibonacci number function vs a more efficient version.
