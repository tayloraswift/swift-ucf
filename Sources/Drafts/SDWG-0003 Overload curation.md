# SDWG-0003 Overload curation

## Introduction


## Motivation

### Page identity

The OCS should function as a page identity. Usage of non-canonical references to the same page should be minimized.


### Robust across API changes

The OCS should be robust across API changes. If a function gains an overload, this should have as little impact as possible on existing pages. In particular, a page’s identity should not change unless absolutely necessary.

The OCS should not require unrelated source changes to maintain documentation stability.


### History-independent

The overload map for a package should be history-independent. It should always be possible to compute the overload map from the source code of a single version of the package. API that existed in prior versions of the package should not influence the overload map of the current version.


### Archivable

The OCS should allow for easy archiving of page metadata from historical versions of a package. It should be possible to combine overload maps from multiple versions of a package to support documentation queries against the entire history of a package.


### Transparent to developers

The OCS should be transparent to developers. It should be possible to understand overload curation behavior without understanding the details of the Swift compiler implementation, such as the Swift ABI.

The OCS should require as little source annotation as possible.


## Proposed solution

### Flat hierarchy

The basic lexical granularity of the OCS is the **full name**.

The following declarations all share the same base name (`f`), but have distinct full names, and will never be treated as related to one another for the purposes of overload curation.

```swift
var f:Int
func f(a:Int)
func f(b:Int)
func f(c:Int)
```

The following declarations all share the same full name (`f`), and will be considered **related overloads**.

```swift
func f(a:Int)
func f(a:Int32)
func f(a:some BinaryInteger)
```

A documentation engine may still choose to display links between “overloads” with different full names, but this is not part of the OCS, because it is already easy to disambiguate between such API as one can simply write the full name. This keeps the OCS easy to understand.


### API layers


### Dominant overloads

Within a group of related overloads, up to one overload may be designated as the **dominant overload**.

If a dominant overload exists, unqualified references to the full name refer to the dominant overload.

If no dominant overload exists, ambiguous references to the full name are **invalid**.


### The dominant overload is the one with documentation

If exactly one declaration within a group of related overloads has an **attached documentation comment**, that declaration is the dominant overload.

If more than one declaration within a group of related overloads has an attached documentation comment, no dominant overload exists.

If no declaration within a group of related overloads has an attached documentation comment, it is still possible to designate a dominant overload by annotating one of the declarations with `@_documentation(metadata: "dominant=true")`. This can be used to provide documentation via a markdown supplement in place of a documentation comment, or merely as a placeholder for future documentation.

If no declaration has an attached documentation comment, and no declaration is annotated, no dominant overload exists.

If a declaration is annotated but a different declaration has an attached documentation comment, the documentation compiler should raise an error.


### All overloads exist in a package-wide, qualified namespace

### Supplemental overloads

