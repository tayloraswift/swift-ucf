# UCF Disambiguator Grammar

A full disambiguator consists of an optional type signature pattern, and an optional list of disambiguation clauses.

```ebnf
Disambiguator ::= \s + SignaturePattern Clauses ? | Clauses ;
DisambiguationSuffix ::= SignatureSuffix Clauses ? | Clauses ;
```


## Filter clauses

```ebnf
Clauses ::= Space '[' Clause ( ',' Clause ) * ']' ;
Clause ::= AlphanumericWord + ( ':' AlphanumericWord + ) ? ;
Space ::= \s + | '-' ;
```

Note that the leading whitespace is considered part of the filter.

```ebnf
AlphanumericWord ::= Space ? [0-9A-Za-z] + Space ? ;
```


## Signatures

A Unidoc-style disambiguator (`SignaturePattern`) always begins with a space character, but UCF also supports the DocC-style syntax which is joined to the base path by a hyphen character (`SignatureSuffix`).

```ebnf
SignaturePattern ::= FunctionPattern | Arrow TypePattern ;
SignatureSuffix ::= '-' FunctionPattern | '->' TypePattern ;
Arrow ::= \s * '->' \s * ;
```

The remaining productions are shared by both syntaxes.

```ebnf
TypePattern ::= TypeElement ( \s * '&' \s * TypeElement ) * ;
TypeElement ::= '~' ? TypeOperand PostfixOperator * ;
TypeOperand ::= NominalPattern | BracketPattern | FunctionPattern ;
PostfixOperator ::= '?' | '!' | '.Type' | '...' ;
```

### Functions and Tuples

A “function” type consists of a `TuplePattern` followed by an optional return arrow (`->`) and a `TypePattern`. If only the tuple is present, the “function” type is a tuple type, and if the tuple contains only one element, the parentheses are discarded and the type inside is promoted to the next level of the AST.

```ebnf
FunctionPattern ::= TuplePattern ( Arrow TypePattern ) ? ;
TuplePattern ::= '(' \s * ( TypePattern ( ',' TypePattern ) * \s * ) ? ')' ;
```

The grammar is specified this way for parser performance, so that it does not need to backtrack after parsing the leading tuple.

### Sugared Collections

A collection type can be either an array type (`[T]`) or a dictionary type (`[K: V]`). For readability, spaces can appear around the colon, but not after the opening bracket or before the closing bracket.

```ebnf
BracketPattern ::= '[' TypePattern ( \s * ':' \s * TypePattern ) ? ']' ;
```

### Nominal Types

```ebnf
NominalPattern ::= PathComponent ( '.' PathComponent ) * ;
PathComponent ::= Identifier GenericArguments ? ;
GenericArguments ::=
    '<'
    \s * TypePattern ( \s * ',' \s * TypePattern ) * \s *
    '>' ;
```

### Identifiers

```ebnf
Identifier ::=
    ( FirstCodepoint NextCodepoint * ) - 'Type'
    | '`' ( - '`' ) + '`' ;
```
