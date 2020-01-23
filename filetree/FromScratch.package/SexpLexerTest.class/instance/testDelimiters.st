test
testDelimiters
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