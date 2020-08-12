test
testAxisFont
	| p |
	p := self newPlotter.
	self assert: (p axisFont isKindOf: AbstractFont)