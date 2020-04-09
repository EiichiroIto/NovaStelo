test
testEvaluateArg
	| i |
	i := self newImporter.
	self assert: (i evaluateArg: 'abc') equals: 'abc'.
	self assert: (i evaluateArg: '123') equals: 123.
	self assert: (i evaluateArg: '123x') equals: '123x'.
	self assert: (i evaluateArg: true) equals: true