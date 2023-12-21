## Chapter 2.

### Exercise 2.01

Work through the examples from this chapter using GHCi.

### Exercise 2.02

Parenthesise the following numeric expressions:

```haskell
2^3*4
2*3+4*5
2+3*4^5
```

### Solution

```haskell
(2^3)*4
(2*3)+(4*5)
2+(3*(4^5))
```

### Exercise 2.03

The script below contains three syntactic errors. Correct these errors and then
check that your script works properly using GHCi.

```haskell
N =  a 'div' length xs
     where
         a = 10
        xs = [1,2,3,4,5]
```

### Solution

`'div'` should be in backticks. `a` and `xs` are not aligned properly. `length
xs` should be parenthesised. `N` cannot be capitalised.

```haskell
n = a `div` (length xs)
    where
        a  = 10
        xs = [1,2,3,4,5]
```

### Exercise 2.04

The library function `last` selects the last element of a non-empty list; for
example, `last [1,2,3,4,5] = 5`. Show how the function `last` could be defined
in terms of the other library functions introuced in this chapter. Can you think
of another possible definition?

### Solution

```haskell
last xs = head (reverse xs)

last [x] = x
last (_:xs) = last xs
```

### Exercise 2.05

The library function `init` removes the last element from a non-empty list; for
example, `init [1,2,3,4,5] = [1,2,3,4]`. Show how `init` could similarly be
defined in two different ways.

### Solution

```haskell
init xs = take (length xs - 1) xs

init xs = reverse (tail (reverse xs))
```
