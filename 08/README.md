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

### Exercise 8.03

Consider the following type of binary trees:

```haskell
data Tree a = Leaf a | Node (Tree a) (Tree a)
```

Let us say that such a tree is *balanced* if the number of leaves in the left
and right subtree of every node differs by at most one, with leaves themselves
being trivially balanced. Define a function `balanced :: Tree a -> Bool` that
decides if a binary tree is balanced or not.

Hint: first define a function that returns the number of leaves in a tree.

### Solution

```haskell
leaves :: Tree a -> Int
leaves (Leaf _) = 1
leaves (Node a b) = leaves a + leaves b

balanced :: Tree a -> Bool
balanced (Leaf _) = True
balanced (Node a b) = abs(leaves a - leaves b) <= 1
                      && balanced a && balanced b
```

### Exercise 8.04

Define a function `balance :: [a] -> Tree a` that converts a non-empty list into
a balanced tree. Hint: first define a function that splits a list into two
halves whose length differs by at most one.

### Solution

```haskell
halve :: [a] -> ([a],[a])
halve [] = ([],[])
halve a  = (take half a, drop half a)
           where half = length a `div` 2

balance :: [a] -> Tree a
balance [x] = Leaf x
balance a = Node (balance l) (balance r)
            where (l,r) = halve a
```

### Exercise 8.05

Given the type declaration

```haskell
data Expr = Val Int | Add Expr Expr
```

define a higher-order function

```haskell
folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
```

such that `folde f g` replaces each `Val` constructor in an expression by the
function `f`, and each `Add` constructor by the function `g`.

### Solution

```haskell
folde :: (Int -> a) -> (a -> a -> a) -> Expr -> a
folde f _ (Val x) = f x
folde f g (Add x y) = g (folde f g x) (folde f g y)
```

### Exercise 8.06

Using `folde`, define a function `eval :: Expr -> Int` that evaluates an
expression to an integer value, and a function `size :: Expr -> Int` that
calculates the number of values in an expression.

### Solution

```haskell
eval :: Expr -> Int
eval e = folde id (+) e

size :: Expr -> Int
size e = folde (\_ -> 1) (+) e
```

### Exercise 8.07

Complete the following instance declarations:

```haskell
instance Eq a => Eq (Maybe a) where
    ...

instance Eq a => Eq [a] where
    ...
```

### Solution

```haskell
instance Eq a => Eq (Maybe a) where
    Nothing == Nothing = True
    Just a  == Just b  = a == b
    _       == _       = False

instance Eq a => Eq [a] where
    []     == []     = True
    [_]    == []     = False
    []     == [_]    = False
    (x:xs) == (y:ys) = x == y && xs == ys
```

### Exercise 8.08

Extend the tautology checker to support the use of logical disjunction (&or;)
and equivalence (&hArr;) in propositions.

### Solution

Assuming the following definitions for disjunction and equivalence:

| A     | B     | A &or; B |
| :---: | :---: |  :---:   |
| F     | F     | F        |
| F     | T     | T        |
| T     | F     | T        |
| T     | T     | T        |

| A     | B     | A &hArr; B |
| :---: | :---: |   :---:    |
| F     | F     | T          |
| F     | T     | F          |
| T     | F     | F          |
| T     | T     | T          |

The only changes to the program were to add these two definitions to the `Prop`
type and in the `vars` equation, and to be able to `eval`uate these definitions
using the built-in `&&` and `==` operators.

See [08.08.hs](./08.08.hs).

### Exercise 8.09

Extend the abstract machine to support the use of multiplication.

### Solution

See [08.09.hs](./08.09.hs).
