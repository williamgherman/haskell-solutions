## Chapter 8.

### Exercise 8.01

In a similar manner to the function `add`, define a recursive multiplication
function `mult :: Nat -> Nat -> Nat` for the recursive type of natural numbers:

Hint: make use of `add` in your definition.

### Solution

```haskell
mult :: Nat -> Nat -> Nat
mult Zero     _    = Zero
mult _        Zero = Zero
mult (Succ m) n    = add n (mult m n)
```

### Exercise 8.02

Although not included in appendix B, the standard prelude defines

```haskell
data Ordering = LT | EQ | GT
```

together with a function

```haskell
compare :: Ord a => a -> a -> Ordering
```

that decides if one value in an ordered type is less than (`LT`), equal to
(`EQ`), or greater than (`GT`) another value. Using this function, redefine the
function `occurs :: Ord a => a -> Tree a -> Bool` for search trees. Why is this
new definition more efficient than the original version?

### Solution

The following solution will only need to run the `compare` function once, while
the original definition compared `x` and `y` several times in the worst case.

```haskell
occurs :: Ord a => a -> Tree a -> Bool
occurs x (Leaf y)
occurs x (Node l y r) =
    case compare x y of
        EQ -> True
        LT -> occurs x l
        GT -> occurs x r
```
