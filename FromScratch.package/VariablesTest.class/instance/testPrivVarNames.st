test
testPrivVarNames
	| v |
	v := self newVariables.
	self assert: v privVarNames class equals: Array.
	v privVarNames: 123.
	self assert: v privVarNames equals: 123.
	v privVarNames: 234.
	self assert: v privVarNames equals: 234.