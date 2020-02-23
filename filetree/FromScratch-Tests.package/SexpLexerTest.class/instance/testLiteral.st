test
testLiteral
	| l |
	l := self newLexer.
	self assert: (l literal: '12') equals: 12.
	self assert: (l literal: '-12') equals: -12.
	self assert: (l literal: '12.5') equals: 12.5.
	self assert: (l literal: '-12.5') equals: -12.5.
	self assert: (l literal: 'a12') equals: 'a12'.
	self assert: (l literal: '%x') equals: '%x'