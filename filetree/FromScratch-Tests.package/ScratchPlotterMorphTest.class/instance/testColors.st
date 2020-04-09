test
testColors
	| p |
	p := self newPlotter.
	self assert: p colors isArray.
	p colors do: [ :each | self assert: each isColor ]