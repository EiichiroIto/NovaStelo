"
A SexpLexerTest is a test class for testing the behavior of SexpLexer
"
Class {
	#name : #SexpLexerTest,
	#superclass : #TestCase,
	#category : #'FromScratch-Tests'
}

{ #category : #test }
SexpLexerTest >> testDelimiters [
	| l |
	l := SexpLexer new.
	self assert: (l delimiters includes: $().
	self assert: (l delimiters includes: $)).
	self assert: (l delimiters includes: $!).
	self assert: (l delimiters includes: $@).
	self assert: (l delimiters includes: Character space).
	self assert: (l delimiters includes: Character tab).
	self assert: (l delimiters includes: Character cr).
	self assert: (l delimiters includes: Character lf).
	self deny: (l delimiters includes: $:).
	($0 to: $9) do: [ :each | self deny: (l delimiters includes: each) ].
	($a to: $z) do: [ :each | self deny: (l delimiters includes: each) ].
	($A to: $Z) do: [ :each | self deny: (l delimiters includes: each) ]
]

{ #category : #test }
SexpLexerTest >> testRead [
	| ret |
	ret := SexpLexer new
		read:
			'(abc (de
f aaa) ghi))'.
	self
		assertCollection: ret asArray
		equals: #($( 'abc' $( 'de' 'f' 'aaa' $) 'ghi' $) $))
]

{ #category : #test }
SexpLexerTest >> testWhiteSpaces [
	| l |
	l := SexpLexer new.
	self deny: (l whiteSpaces includes: $().
	self deny: (l whiteSpaces includes: $)).
	self deny: (l whiteSpaces includes: $!).
	self deny: (l whiteSpaces includes: $@).
	self assert: (l whiteSpaces includes: Character space).
	self assert: (l whiteSpaces includes: Character tab).
	self assert: (l whiteSpaces includes: Character cr).
	self assert: (l whiteSpaces includes: Character lf).
	self deny: (l whiteSpaces includes: $:).
	($0 to: $9) do: [ :each | self deny: (l whiteSpaces includes: each) ].
	($a to: $z) do: [ :each | self deny: (l whiteSpaces includes: each) ].
	($A to: $Z) do: [ :each | self deny: (l whiteSpaces includes: each) ]
]
