# A LISP implementation in Ruby, with Treetop

Experimental project with the only goal to implement a simple LISP in Ruby.

# Grammar

## Simple literal
```lisp
(1)
(x)
```

## Variable definition

```lisp
(define x 1)
(define x 1.1)
(define x "hello world")
(define new_x x)
```

## Builtin types arithmetic

```lisp
(+ 42 42)
(+ x 42)
(* x y)
```

## Function creation

```lisp
(function (toto) (42))
```

# LICENSE

GPLv3
