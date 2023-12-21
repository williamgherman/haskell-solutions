## Chapter 1.

### Exercise 1.01

Give another possible calculation for the result of `double (double 2)`.

### Solution

```haskell
double (double 2)   -- apply outer double
double 2 + double 2 -- apply inner left double
4 + double 2        -- apply inner right double
4 + 4               -- apply +
8
```

### Exercise 1.02

Show that `sum [x] = x` for any number `x`.

### Solution

```haskell
sum [x]     -- apply sum
x + sum []  -- apply sum
x + 0       -- apply +
x
```

### Exercise 1.03

Define a function `product` that produces the product of a list of numbers, and
show using your definition that `product [2,3,4] = 24`.

### Solution

```haskell
product [x]    = x
product (x:xs) = x * product xs

product [2,3,4]         -- apply product
2 * product [3,4]       -- apply product
2 * (3 * product [4])   -- apply product
2 * (3 * 4)             -- apply *
2 * 12                  -- apply *
24
```

### Exercise 1.04

How should the definition of the function `qsort` be modified so that it
produces a *reverse* sorted version of a list?

### Solution

```haskell
qsort []     = []
qsort (x:xs) = qsort larger ++ [x] ++ qsort smaller
               where
                  smaller = [a | a <- xs, a <= x]
                  larger  = [b | b <- xs, b > x]
```


### Exercise 1.05

What would be the effect of replacing `<=` by `<` in the original definition of
`qsort`? Hint: consider the example `qsort [2,2,3,1,1]`.

### Solution

Duplicates would be removed from the resulting sort, since `a = x` will not be
accepted by either list comprehension.
