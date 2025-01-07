# Codelinks

**Codelinks**, also known as **symbol links**, are a markdown shorthand for referencing Swift declarations in documentation.

You write codelinks using double backticks. Here are some examples:

```markdown
``Int``
``String``
``String.Index``
```

A Swift documentation engine, such as [Unidoc](https://github.com/tayloraswift/swift-unidoc) or [DocC](https://www.swift.org/documentation/docc/), can resolve and render these codelinks like this:

``Int``
``String``
``String.Index``

But in a regular markdown viewer, they will just look like this:

`Int`
`String`
`String.Index`


## Displaying part of a declaration’s name

Use the slash character (`/`) in place of the period (`.`) separator to mark where you want the visible portion of a declaration’s name to begin.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``String.Index`` ` | ``String.Index`` |
| ` ``String/Index`` ` | ``String/Index`` |

Readers using a regular markdown viewer will see the entire path, but documentation engines will only display the specified path suffix.


## Linking to functions and subscripts

If you want to link to a specific function or subscript, you must include all of the function’s argument labels (including defaulted arguments), appending a colon (`:`) after each label, including the last one.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``String.init(decoding:as:)`` ` | ``String.init(decoding:as:)`` |

If the function takes no arguments, you can omit the parentheses.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Sequence.max`` ` | ``Sequence.max`` |

However, you can add the parentheses anyway to exclude properties (and much more rarely, types) as possible matches.


## Linking to operators

To link to an operator, spell it as-is, without replacing or escaping any special characters.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Int.+(_:_:)`` ` | ``Int.+(_:_:)`` |
| ` ``Int./(_:_:)`` ` | ``Int./(_:_:)`` |
| ` ``Comparable....(_:_:)`` ` | ``Comparable....(_:_:)`` |


## Linking to types

When linking to types, don’t include the generic parameters.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Array`` ` | ``Array`` |
| ` ``Dictionary`` ` | ``Dictionary`` |


## Linking to modules

You can link to a module by using the module’s name.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Foundation`` ` | ``Foundation`` |

## Relative and absolute paths

Documentation that is attached to a declaration (such as an inline doccomment) can omit leading components of the codelink path.

For example, if you are documenting a type named `Heap.Index` that contains a property named `offset`, you can use all of the following to refer to the property:

```
``offset``
``Index/offset``
``Heap.Index/offset``
```

Matches that appear lexically closer to the declaration will take precedence over those from outer scopes.


### Qualifying with module names

You can prepend a module name to a codelink to fully qualify it.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``_Concurrency.AsyncStream`` ` | ``_Concurrency.AsyncStream`` |
| ` ``_Concurrency/AsyncStream`` ` | ``_Concurrency/AsyncStream`` |

If a module re-exports a declaration from another module, you can use the re-exporting module’s name in place of the original module’s name.


### Using absolute paths

You can prepend a slash character (`/`) to a codelink to force it to resolve from the root of the package hierarchy.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``/Swift.Int`` ` | ``/Swift.Int`` |
| ` ``/Swift/Int`` ` | ``/Swift/Int`` |

This is useful if a module contains a type with the same name as the module itself.


## Disambiguation filters

If a codelink is ambiguous, you add **disambiguation filters** in brackets (`[]`) after the codelink.


### Filtering by phylum

You can filter a codelink by phylum to disambiguate it. For example, if you have a static and an instance property with the same name, you can use `[static var]` or `[var]` to specify which one you want.

@Snippet(id: Codelinks, slice: PHYLUM)

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.property [var]`` ` | ``Example.property [var]`` |
| ` ``Example.property [static var]`` ` | ``Example.property [static var]`` |

Below is an exhaustive list of all supported phylum filters.

| Disambiguator        | Notes |
| -------------------- | ----- |
| `[actor]`            |       |
| `[associatedtype]`   |       |
| `[enum]`             |       |
| `[case]`             |       |
| `[class]`            | Matches non-actor classes only. |
| `[class func]`       |       |
| `[class subscript]`  |       |
| `[class var]`        |       |
| `[deinit]`           |       |
| `[func]`             | Also matches global operators and functions. |
| `[init]`             |       |
| `[macro]`            |       |
| `[protocol]`         |       |
| `[static func]`      | Also matches scoped operators. |
| `[static subscript]` |       |
| `[static var]`       |       |
| `[struct]`           |       |
| `[subscript]`        |       |
| `[typealias]`        |       |
| `[var]`              | Also matches global variables. |


### Protocol requirements and default implementations

You can use `[requirement]` (or `[requirement: true]`) to match only protocol requirements, and `[requirement: false]` to exclude them.

@Snippet(id: Codelinks, slice: REQUIREMENTS)

| Syntax | Renders as |
| ------ | ---------- |
| ` ``ExampleProtocol.f [requirement]`` ` | ``ExampleProtocol.f [requirement]`` |
| ` ``ExampleProtocol.f [requirement: false]`` ` | ``ExampleProtocol.f [requirement: false]`` |


### Multiple filters

You can specify multiple filters by separating them with commas.

@Snippet(id: Codelinks, slice: REQUIREMENTS_AND_PHYLA)

| Syntax | Renders as |
| ------ | ---------- |
| ` ``AnotherProtocol.g [func, requirement]`` ` | ``AnotherProtocol.g [func, requirement]`` |
| ` ``AnotherProtocol.g [func, requirement: false]`` ` | ``AnotherProtocol.g [func, requirement: false]`` |
| ` ``AnotherProtocol.g [static func, requirement]`` ` | ``AnotherProtocol.g [static func, requirement]`` |
| ` ``AnotherProtocol.g [static func, requirement: false]`` ` | ``AnotherProtocol.g [static func, requirement: false]`` |


## Disambiguating overloads

You can disambiguate overloads by specifying the types in their function signatures.

To disambiguate by argument types, write the types in parentheses after the function name and a space.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Int.init(_:) (Float)`` ` | ``Int.init(_:) (Float)`` |
| ` ``Int.init(_:) (Double)`` ` | ``Int.init(_:) (Double)`` |

If you like, you can use a hyphen (`-`) instead of a space.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Int.init(_:)-(Float)`` ` | ``Int.init(_:)-(Float)`` |
| ` ``Int.init(_:)-(Double)`` ` | ``Int.init(_:)-(Double)`` |

The hyphen-joined form is useful when you want to use custom link text, which requires encoding the target as a URL.

| Syntax | Renders as |
| ------ | ---------- |
| ` [custom text](Int.init(_:)-(Float)) ` | [custom text](Int.init(_:)-(Float)) |
| ` [custom text](Int.init(_:)-(Double)) ` | [custom text](Int.init(_:)-(Double)) |

Do not include modifiers such as `inout`, `borrowing`, or `consuming`, or attributes such as `@escaping` or `@Sendable` in the type signature.


### Partial signatures

If overloaded functions have multiple arguments, you can specify only the ones that are different, and omit the rest by using the underscore character (`_`).

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.f(x:y:) (_, String)`` ` | ``Example.f(x:y:) (_, String)`` |
| ` ``Example.f(x:y:) (_, Substring)`` ` | ``Example.f(x:y:) (_, Substring)`` |

>   Important:
>   You can only use placeholder types at the top level of the signature, not nested within other types.


### Arrays, Dictionaries, and Optionals

When specifying an ``Array`` or ``Dictionary`` type, use square brackets (`[]`) and colons (`:`) to specify the type arguments. Similarly, use a postfix question mark (`?`) to denote ``Optional`` types, or a postfix exclamation mark (`!`) for implicitly unwrapped optionals.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.g(_:) ([Int])`` ` | ``Example.g(_:) ([Int])`` |
| ` ``Example.g(_:) ([Int: String])`` ` | ``Example.g(_:) ([Int: String])`` |
| ` ``Example.g(_:) (Int!)`` ` | ``Example.g(_:) (Int!)`` |
| ` ``Example.g(_:) ([Int].Type)`` ` | ``Example.g(_:) ([Int].Type)`` |
| ` ``Example.g(_:) ([Int: String].Type)`` ` | ``Example.g(_:) ([Int: String].Type)`` |
| ` ``Example.g(_:) (Int?.Type)`` ` | ``Example.g(_:) (Int?.Type)`` |

For readability, you can include spaces around the colons, but not between the other special characters.


### Variadic arguments

Use a postfix ellipsis (`...`) to denote variadic arguments.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.g(_:) (Int...)`` ` | ``Example.g(_:) (Int...)`` |


### Type arguments

When specifying a generic type, use angle brackets (`<>`) to enclose the type arguments.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.h(_:) (Set<Int>)`` ` | ``Example.h(_:) (Set<Int>)`` |
| ` ``Example.h(_:) (Int?)`` ` | ``Example.h(_:) (Int?)`` |
| ` ``Example.h(_:) (Dictionary<Int, Int>.Index)`` ` | ``Example.h(_:) (Dictionary<Int, Int>.Index)`` |

Always use the shorthand form of ``Array``, ``Dictionary``, and ``Optional`` types, even if the source declaration uses the full type name.

>   Note:
>   Although `Dictionary<Int, Int>.Type` metatype can (and therefore must) be resugared to `[Int: Int].Type`, the `Dictionary<Int, Int>.Index` type cannot be rewritten as `[Int: Int].Index` as this is not valid Swift syntax.


### Generics and existentials

Do not include the `any` keyword when specifying existential types, just the protocol name. Similarly, do not include the `some` keyword when specifying generic types.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.h(_:) (StringProtocol)`` ` | ``Example.h(_:) (StringProtocol)`` |
| ` ``Example.h(_:) (Error)`` ` | ``Example.h(_:) (Error)`` |

If the source declaration used a named generic parameter, you must use that same name in the codelink, even if it has an equivalent inline `some` spelling.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.h(_:) (T)`` ` | ``Example.h(_:) (T)`` |

This means that renaming generic parameters, although ABI-compatible, is documentation-breaking.


### Protocol composition types

When specifying a protocol composition type, use the `&` character to separate the protocols.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.k(_:) (Sendable & CustomStringConvertible)`` ` | ``Example.k(_:) (Sendable & CustomStringConvertible)`` |
| ` ``Example.k(_:) (CustomStringConvertible & Sendable)`` ` | ``Example.k(_:) (CustomStringConvertible & Sendable)`` |

The order of the protocols is significant, and must match the order in the source declaration.

As with renaming generic parameters, reordering protocols in a composition type is documentation-breaking, even though it is ABI-compatible.


### Tuple types

When specifying a tuple type, use parentheses to enclose the element types. A single-element tuple is equivalent to its element type.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.l(_:) (())`` ` | ``Example.l(_:) (())`` |
| ` ``Example.l(_:) ((Int))`` ` | ``Example.l(_:) ((Int))`` |
| ` ``Example.l(_:) ((Int, Int))`` ` | ``Example.l(_:) ((Int, Int))`` |


### Function types

When specifying a function type, use the `->` token to provide the return type. Do not include function attributes, or keywords such as `throws`, `rethrows`, or `async`.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.m(_:) ((Int) -> Int)`` ` | ``Example.m(_:) ((Int) -> Int)`` |
| ` ``Example.m(_:) ((Int) -> ())`` ` | ``Example.m(_:) ((Int) -> ())`` |


### Parameter packs

To specify a parameter pack expansion, spell a single instance of the parameter pack. Do not include a trailing ellipsis (as it is not a variadic argument), and do not include the `repeat` or `each` keywords.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.n(_:) ([T])`` ` | ``Example.n(_:) ([T])`` |
| ` ``Example.n(_:) ([T: Int])`` ` | ``Example.n(_:) ([T: Int])`` |


### Noncopyable types

Spell types with suppressed conformances with a leading tilde (`~`) character. Don’t include the ownership specifier.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.n(_:) (~Copyable)`` ` | ``Example.n(_:) (~Copyable)`` |


### Typealiases and `Self`

If the original declaration uses a typealias, you must use the same typealias in the codelink.

The `Self` type is not a typealias, and is only allowed when it is truly dynamic, such as in a class or protocol member. If `Self` is an [SE-0068](https://github.com/swiftlang/swift-evolution/blob/main/proposals/0068-universal-self.md) static type, you must replace it with the actual type name, including any generic parameters.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.o(_:) (Example)`` ` | ``Example.o(_:) (Example)`` |
| ` ``Example.o(_:) (UTF8.Type)`` ` | ``Example.o(_:) (UTF8.Type)`` |
| ` ``Example.o(_:) (Void)`` ` | ``Example.o(_:) (Void)`` |
| ` ``ExampleProtocol.o(_:) (Self)`` ` | ``ExampleProtocol.o(_:) (Self)`` |
| ` ``ExampleProtocol.o(_:) (Void)`` ` | ``ExampleProtocol.o(_:) (Void)`` |


## Disambiguating return types

Overloading on return type is discouraged in Swift, but it is possible to disambiguate by return type similarly to how you disambiguate by argument types.

For the purposes of link resolution, function outputs are treated as splatted tuples, and individual element types can be ignored using the underscore character (`_`).

Specify return types using the `->` token. The spaces around the arrow are optional.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.r(_:) -> ()`` ` | ``Example.r(_:) -> ()`` |
| ` ``Example.r(_:) -> Int`` ` | ``Example.r(_:) -> Int`` |
| ` ``Example.r(_:) -> (Int, String)`` ` | ``Example.r(_:) -> (Int, String)`` |

If you replace all of the types with underscores, the codelink will match any overload that returns a tuple of that length.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.r(_:) -> _`` ` | ``Example.r(_:) -> _`` |
| ` ``Example.r(_:) -> (_, _)`` ` | ``Example.r(_:) -> (_, _)`` |

A single underscore matches only overloads that return a scalar type. To express a true wildcard, simply omit the entire return type.


### Methods and subscripts

If needed, you can provide patterns for both the argument types and the return type.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``Example.s(_:) (Int) -> (Int, String)`` ` | ``Example.s(_:) (Int) -> (Int, String)`` |
| ` ``Example.s(_:) (String) -> (Int, String)`` ` | ``Example.s(_:) (String) -> (Int, String)`` |


### Initializers

Even though initializers formally return `Self`, disambiguating initializers by return type is not supported.


### Properties

For the purposes of link resolution, properties are treated as functions with no arguments and a return type of the property’s own type.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``ExampleProtocol.x -> Int`` ` | ``ExampleProtocol.x -> Int`` |
| ` ``ExampleProtocol.x -> [Int]`` ` | ``ExampleProtocol.x -> [Int]`` |
| ` ``ExampleProtocol.x -> (_, Int)`` ` | ``ExampleProtocol.x -> (_, Int)`` |


## Combining multiple filters

If you need to use filters alongside signature patterns, put the filters in brackets (`[]`) after the signature.

| Syntax | Renders as |
| ------ | ---------- |
| ` ``ExampleProtocol/g(_:) (Int32) [requirement]`` ` | ``ExampleProtocol/g(_:) (Int32) [requirement]`` |
| ` ``ExampleProtocol/g(_:) (Int64) -> () [requirement]`` ` | ``ExampleProtocol/g(_:) (Int64) -> () [requirement]`` |
| ` ``ExampleProtocol/g(_:) (Int64) -> Int64 [requirement]`` ` | ``ExampleProtocol/g(_:) (Int64) -> Int64 [requirement]`` |
| ` ``ExampleProtocol/g(_:) (Int32) [requirement: false]`` ` | ``ExampleProtocol/g(_:) (Int32) [requirement: false]`` |
| ` ``ExampleProtocol/g(_:) (Int64) -> () [requirement: false]`` ` | ``ExampleProtocol/g(_:) (Int64) -> () [requirement: false]`` |
| ` ``ExampleProtocol/g(_:) (Int64) -> Int64 [requirement: false]`` ` | ``ExampleProtocol/g(_:) (Int64) -> Int64 [requirement: false]`` |
