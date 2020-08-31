# A Lisp Interpreter In OCaml

```
Tiger got to hunt,
Bird got to fly;
Lisper got to sit and wonder, (Y (Y Y))?

Tiger got to sleep,
Bird got to land;
Lisper got to tell himself he understand.

-- Kurt Vonnegut, modified by Darius Bacon 
```

OCaml is an amazing language for writing interpreters and compilers. Even the original Rust compiler was [bootstrapped](https://github.com/rust-lang/rust/tree/ef75860a0a72f79f97216f8aaa5b388d98da6480/src/boot) with OCaml before it was able to host itself. 

Writing a Lisp interpreter feels like an appropriate exercise to explore programming in OCaml, but also serves as an introduction to working on compilers in general.

I'm following along with the [Writing a Lisp](https://bernsteinbear.com/blog/lisp/00_fundamentals/) series by [Max Bernstein](https://bernsteinbear.com/).


