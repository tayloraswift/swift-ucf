# SDWG-0002: Type signature disambiguation

-   Proposal:
    SDWG-0002

-   Author(s):
    Dianna Ma (taylorswift)

-   Implementation:
    Available since [Unidoc](https://github.com/tayloraswift/swift-unidoc) 0.20.0

-   Review:
    TBD


## Introduction

This proposal describes the type signature-based UCF disambiguation syntax. It builds on work by [David Rönnqvist](https://forums.swift.org/t/human-readable-alternative-for-docc-symbol-link-disambiguation/65792) and attempts to provide a formal specification for the signature-based symbol link syntax.


## Concepts

For the purposes of link disambiguation, all overloadable declarations in Swift have a **function signature**, which consists of an **inputs** tuple and an **output** tuple. A signature disambiguator can contain patterns that match on the input tuple, the output tuple, or both.

### Output tuples

The output tuple is frequently a single-element tuple (that is to say, not a tuple at all), but supports up to one level of destructuring. For example, a `Void`-returning function returns a zero-element tuple, and a function that returns `(Int, Int)` returns a two-element tuple.

### Initializers and Properties

Initializers are treated as having no output types, even though they technically return `Self`.

Properties are treated as having no input types. A property’s type annotation is treated as its return type for the purposes of disambiguation.

### Enum Cases

Enum cases do not participate in signature-based disambiguation. They cannot be overloaded on their base name, and if they are overloaded by type methods, they can always be uniquely referenced using the `[case]` disambiguator.


## Normalization

Parentheses around types are always stripped. That is, `((Int)) -> ()`` is equivalent to `(Int) -> ()`. However, `((Int, Int)) -> ()` is a function that takes one input, a tuple of type `(Int, Int)`. It is not equivalent to `(Int, Int) -> ()`.
