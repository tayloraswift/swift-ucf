# SDWG-0000: Codelink paths

-   Proposal:
    SDWG-0000

-   Author(s):
    Dianna Ma (taylorswift)

-   Implementation:
    Available since [Unidoc](https://github.com/tayloraswift/swift-unidoc) 0.3.14

-   Review:
    [pitch](https://forums.swift.org/t/unified-documentation-links/68128)


## Introduction

This proposal describes the UCF vector path syntax. Please refer to <doc:Motivation> for an overview of prior art, including the DocC symbol link format.


## Motivation

Many writers of Swift documentation find it valuable to have a lightweight Markdown syntax such as ` ``Array`` ` for linking to modules and declarations such as ``Array``. Since declarations can be nested, it is also useful to be able to express multi-component paths and customize the number of components that are displayed in the rendered documentation. For example, an author may wish to link to ``AsyncStream.Continuation.yield(_:)`` but only display the last two components, ``AsyncStream/Continuation.yield(_:)``.


## Proposed format

The unified codelink format uses double backticks when embedded in Markdown documents, like the existing DocC syntax. DocC symbol links such as ` ``Sequence/Element`` ` are also valid UCF expressions, and when resolved successfully, render the same way in the documentation.


### Case sensitive

The unified codelink format is case-sensitive. This is consistent with the behavior of Swift identifiers, reduces the likelihood of ambiguous name collisions, and helps us avoid the complexity of a case-insensitive grammar.


### Path separator

The unified codelink format uses the `.` character to join vector links. The `/` character is also a valid path separator, but only components that appear after the last `/` will appear in the rendered documentation. This means that prior to the last `/`, the two path separators are interchangeable.

| Codelink                     | Renders as               |
| ---------------------------- | ------------------------ |
| ` ``Unicode.Scalar.value`` ` | ``Unicode.Scalar.value`` |
| ` ``Unicode/Scalar.value`` ` | ``Unicode/Scalar.value`` |
| ` ``Unicode.Scalar/value`` ` | ``Unicode.Scalar/value`` |
| ` ``Unicode/Scalar/value`` ` | ``Unicode/Scalar/value`` |


Multiple consecutive path separators are forbidden. This prevents ambiguity with custom operators.

| Codelink               | Renders as         | Parses as               |
| ---------------------- | ------------------ | ----------------------- |
| ` ``Real...(_:_:)`` `  | ``Real...(_:_:)``  | `["Real", "..(_:_:)"]`  |
| ` ``Real/..(_:_:)`` `  | ``Real/..(_:_:)``  | `["Real", "..(_:_:)"]`  |
| ` ``Real....(_:_:)`` ` | ``Real....(_:_:)`` | `["Real", "...(_:_:)"]` |
| ` ``Real/...(_:_:)`` ` | ``Real/...(_:_:)`` | `["Real", "...(_:_:)"]` |
| ` ``Real./(_:_:)`` `   | ``Real./(_:_:)``   | `["Real", "/(_:_:)"]`   |
| ` ``Real//(_:_:)`` `   | ``Real//(_:_:)``   | `["Real", "/(_:_:)"]`   |


If a path component begins with an operator character, all subsequent `.` characters are treated as part of the operator name.

| Codelink               | Renders as         | Parses as               |
| ---------------------- | ------------------ | ----------------------- |
| ` ``Real../.(_:_:)`` ` | ``Real../.(_:_:)`` | `["Real", "./.(_:_:)"]` |
| ` ``Real/./.(_:_:)`` ` | ``Real/./.(_:_:)`` | `["Real", "./.(_:_:)"]` |


### Trailing slashes

Trailing slashes are allowed in vector links, and have no effect on the appearance of the rendered codelink. This has the potential to truncate bare operator references, if the operator name ends with a `/` character. Therefore, operators **must** be written with their full argument tuples.

| Codelink               | Renders as         | Parses as               |
| ---------------------- | ------------------ | ----------------------- |
| ` ``Real./(_:_:)/`` `  | ``Real./(_:_:)/``  | `["Real", "/(_:_:)"]`   |


### Namespacing

The unified codelink format uses implicit namespacing, and behaves similarly to namespacing in Swift source code. However, unlike Swift source code, it also supports explicit namespacing using the `/` prefix.

A `/` character followed by a single identifier is treated as a module name, and resolves to module-level documentation, if any exists.

A unified codelink cannot start with multiple consecutive `/` characters. It is possible to force the appearance of the module name in a vector link by using the `.` separator.

| Codelink           | Renders as     |
| ------------------ | -------------- |
| ` ``/Swift/Int`` ` | ``/Swift/Int`` |
| ` ``/Swift.Int`` ` | ``/Swift.Int`` |
