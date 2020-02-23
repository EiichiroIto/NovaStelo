test
testPrivVars
	| v |
	v := self newVariables.
	self assert: v privVars isNil.
	v privVars: 123.
	self assert: v privVars equals: 123.
	v privVars: 234.
	self assert: v privVars equals: 234.