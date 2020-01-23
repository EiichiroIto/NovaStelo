test
testWhiteSpaces
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