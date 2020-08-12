test
testFontAt
	| t f |
	t := self newTranslator.
	f := self newFont1.
	t fontAt: 'test1' put: f.
	self assert: (t fontAt: 'test1') equals: f.
	self assert: (t fontAt: 'test2') equals: t defaultFont