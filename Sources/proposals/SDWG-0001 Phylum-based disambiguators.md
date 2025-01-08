# SDWG-0001: Phylum-based disambiguators

-   Proposal:
    SDWG-0001

-   Author(s):
    Dianna Ma (taylorswift)

-   Implementation:
    Available since [Unidoc](https://github.com/tayloraswift/swift-unidoc) 0.3.14

-   Review:
    [pitch](https://forums.swift.org/t/unified-documentation-links/68128)


## Introduction

This proposal describes the phylum-based UCF disambiguation syntax. Please refer to <doc:Motivation> for an overview of prior art, including the DocC symbol link format.


## Motivation

Many writers of Swift documentation are accustomed to disambiguating symbol references either by phylum or ABI hash. For example, given the following API, an author may wish to link to the original enum case, or the `static func` convenience constructor.

```swift
public
enum RequestPayload
{
    case gzip([UInt8])
}
extension RequestPayload
{
    public static
    func gzip(_ string:String) -> Self
}
```

Although it is also possible to disambiguate by ABI hash, it is almost always [more desirable](https://forums.swift.org/t/human-readable-alternative-for-docc-symbol-link-disambiguation/65792/12) to disambiguate by phylum whenever possible, as the phylum is more robust and does not vary across platforms.

Because it can be difficult to remember how to express a phylum-based selector, it is motivating to use spellings that reflect how declarations are originally written in source.


## Proposed format

The unified codelink format supports phylum- and ABI hash-based disambiguators. Both types of disambiguators appear in brackets at the end of the codelink. To prevent ambiguity, the hash disambiguator is always written in uppercase base-36. Disambiguators never appear in rendered documentation.

| Codelink                | Disambiguator     |
| ----------------------- | ----------------- |
| ` ``Struct [struct]`` ` | `phylum = struct` |
| ` ``Struct [STRUCT]`` ` | `hash = STRUCT`   |


The space before the opening bracket is mandatory. Spaces can appear inside the brackets, if the corresponding swift keyphrase contains a space.

| Codelink                                  | Renders as                            | Disambiguator              |
| ----------------------------------------- | ------------------------------------- | -------------------------- |
| ` ``Class/max [var]`` `                   | ``Class/max [var]``                   | `phylum = var`             |
| ` ``Class/max [class var]`` `             | ``Class/max [class var]``             | `phylum = class var`       |
| ` ``Class/subscript [class subscript]`` ` | ``Class/subscript [class subscript]`` | `phylum = class subscript` |
| ` ``Class/subscript [subscript]`` `       | ``Class/subscript [subscript]``       | `phylum = subscript`       |


All keywords must be present. For example, the `[func]` disambiguator always selects a global or instance function, and never a class or static function. Similarly, you cannot use `[class]` to select a class member of any phylum; it will only ever match a non-actor class type.

The `[actor]` disambiguator is the only disambiguator that can match an actor type.

There is no disambiguator for operators; operators always use one of the `[func]` or `[static func]` disambiguators.

Backticks are never used to escape keywords. Therefore, in rare cases the `[subscript]`, `[deinit]`, or `[init]` disambiguators may be needed despite the keyword also appearing in the symbol name.

| Codelink                           | Renders as                     | Disambiguator        |
| ---------------------------------- | ------------------------------ | -------------------- |
| ` ``Fake.subscript [subscript]`` ` | ``Fake.subscript [subscript]`` | `phylum = subscript` |
| ` ``Fake.subscript [case]`` `      | ``Fake.subscript [case]``      | `phylum = case`      |
| ` ``Fake.init [init]`` `           | ``Fake.init [init]``           | `phylum = init`      |
| ` ``Fake.init [case]`` `           | ``Fake.init [case]``           | `phylum = case`      |



To aid searchability, the `[let]` disambiguator is forbidden; all such properties use the `[var]` disambiguator instead.

Below is an exhaustive list of all bracketed keyword sequences.

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


### Backwards compatibility

For backwards compatibility with DocC, the unified codelink format also supports hyphen-prefixed disambiguators.

The legacy disambiguators behave the same way they do in DocC. This means some legacy disambiguators express filters that do not exist among the modern disambiguators:

| Legacy disambiguator      | Modern equivalent  |
| ------------------------- | ------------------ |
| `-swift.associatedtype`   | `[associatedtype]` |
| `-swift.enum`             | `[enum]`           |
| `-swift.enum.case`        | `[case]`           |
| `-swift.class`            | no equivalent      |
| `-swift.func`             | no equivalent      |
| `-swift.func.op`          | no equivalent      |
| `-swift.var`              | no equivalent      |
| `-swift.deinit`           | `[deinit]`         |
| `-swift.init`             | `[init]`           |
| `-swift.method`           | no equivalent      |
| `-swift.property`         | no equivalent      |
| `-swift.subscript`        | `[subscript]`      |
| `-swift.macro`            | `[macro]`          |
| `-swift.protocol`         | `[protocol]`       |
| `-swift.struct`           | `[struct]`         |
| `-swift.typealias`        | `[typealias]`      |
| `-swift.type.method`      | no equivalent      |
| `-swift.type.property`    | no equivalent      |
| `-swift.type.subscript`   | no equivalent      |


### Unrelated disambiguators

For arcane historical reasons, XCode sometimes autofills interior path components with disambiguators. For backwards compatibility, the unified codelink format accepts and **ignores** all such disambiguators, as long as the next path component uses the `/` path separator.

| Codelink                         | Allowed?                           |
| -------------------------------- | ---------------------------------- |
| ` ``Sloth-swift.struct/color`` ` | yes (``Sloth-swift.struct/color``) |
| ` ``Sloth-swift.struct.color`` ` | no                                 |


## Future directions

### Linking to a protocol requirement with default implementations

Protocol requirements with default implementations are a frequent cause of link ambiguity. Because default implementations almost always have the same phylum as the requirement they witness, there is usually no way to select the requirement without resorting to ABI hashes.

We could potentially introduce a `[required]` disambiguator to select the requirement, but this would constitute a deviation from the original principle that the disambiguator should reflect the original source spelling.

```
/// ``Sequence.underestimatedCount [required]``
```

Alternatively, we could generalize the syntax to support labeled expressions, such as `[requirement: true]`.
