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

Use the slash character (`/`) in place of the period (`.`) separator to delimit the portion of a declaration’s name that you want to display. Only the portion after the last slash will be shown.

```
``String/Index``
```

``String/Index``

Readers using a regular markdown viewer will see the entire path, but documentation engines will only display the specified path suffix.


## Linking to functions and subscripts

If you want to link to a specific function or subscript, you must include all of the function’s argument labels (including defaulted arguments), appending a colon (`:`) after each label, including the last one.

```markdown
``String.init(decoding:as:)``
```

``String.init(decoding:as:)``

If the function takes no arguments, you can omit the parentheses.

```markdown
``Sequence.max``
```

``Sequence.max``

However, you can add the parentheses anyway to exclude properties (and much more rarely, types) as possible matches.


## Linking to operators

To link to an operator, spell it as-is, without replacing or escaping any special characters.

```markdown
``Int.+(_:_:)``
``Int./(_:_:)``
``Comparable....(_:_:)``
```

``Int.+(_:_:)``
``Int./(_:_:)``
``Comparable....(_:_:)``


## Linking to types

When linking to types, don’t include the generic parameters.

```markdown
``Array``
``Dictionary``
```

``Array``
``Dictionary``


## Linking to modules

You can link to a module by using the module’s name.

```markdown
``Foundation``
```

``Foundation``


## Relative and absolute paths

Documentation that is attached to a declaration (such as an inline doccomment) can omit leading components of the codelink path.

For example, if you are documenting a type named `Heap.Index` that contains a property named `offset`, you can use all of the following to refer to the property:

```markdown
``offset``
``Index/offset``
``Heap.Index/offset``
```

Matches that appear lexically closer to the declaration will take precedence over those from outer scopes.


### Qualifying with module names

You can prepend a module name to a codelink to fully qualify it.

```
``_Concurrency.withCheckedContinuation(isolation:function:_:)``
```

``_Concurrency.withCheckedContinuation(isolation:function:_:)``

If you don’t want the module name to show up, use the slash character (`/`) to hide it.

```
``_Concurrency/withCheckedContinuation(isolation:function:_:)``
```

``_Concurrency/withCheckedContinuation(isolation:function:_:)``

If a module re-exports a declaration from another module, you can use the re-exporting module’s name in place of the original module’s name.


### Using absolute paths

You can prepend a slash character (`/`) to a codelink to force it to resolve from the root of the package hierarchy.

```
``/Swift/Int``
``/Swift.Int``
```

``/Swift/Int``
``/Swift.Int``

This is useful if a module contains a type with the same name as the module itself.


## Disambiguation filters

If a codelink is ambiguous, you add **disambiguation filters** in brackets (`[]`) after the codelink.


### Filtering by phylum

You can filter a codelink by phylum to disambiguate it. For example, if you have a static and an instance property with the same name, you can use `[static var]` or `[var]` to specify which one you want.

@Snippet(id: Codelinks, slice: PHYLUM)

```markdown
``Example.property [var]``
``Example.property [static var]``
```

``Example.property [var]``
``Example.property [static var]``


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

```markdown
``ExampleProtocol.f [requirement]``
``ExampleProtocol.f [requirement: false]``
```

``ExampleProtocol.f [requirement]``
``ExampleProtocol.f [requirement: false]``


### Multiple filters

You can specify multiple filters by separating them with commas.

@Snippet(id: Codelinks, slice: REQUIREMENTS_AND_PHYLA)

```markdown
``AnotherProtocol.g [func, requirement]``
``AnotherProtocol.g [func, requirement: false]``
``AnotherProtocol.g [static func, requirement]``
``AnotherProtocol.g [static func, requirement: false]``
```

``AnotherProtocol.g [func, requirement]``
``AnotherProtocol.g [func, requirement: false]``
``AnotherProtocol.g [static func, requirement]``
``AnotherProtocol.g [static func, requirement: false]``


## Disambiguating overloads

You can disambiguate overloads by specifying the types in their function signatures.

To disambiguate by argument types, write the types in parentheses after the function name and a space.

```markdown
``Int.init(_:) (Float)``
``Int.init(_:) (Double)``
```

``Int.init(_:) (Float)``
``Int.init(_:) (Double)``

Do not include modifiers such as `inout`, `borrowing`, or `consuming` in the type signature.


### Partial signatures

If overloaded functions have multiple arguments, you can specify only the ones that are different, and omit the rest by using the underscore character (`_`).

```markdown
``String.init(cString:encoding:) (UnsafePointer<CChar>, _)``
``String.init(cString:encoding:) ([CChar], _)``
```

``String.init(cString:encoding:) (UnsafePointer<CChar>, _)``
``String.init(cString:encoding:) ([CChar], _)``


### Generics and existentials

Do not include the `any` keyword when specifying existential types, just the protocol name. Similarly, do not include the `some` keyword when specifying generic types.

```markdown
``Example.h(_:) (StringProtocol)``
``Example.h(_:) (Error)``
```

``Example.h(_:) (StringProtocol)``
``Example.h(_:) (Error)``

If the source declaration
