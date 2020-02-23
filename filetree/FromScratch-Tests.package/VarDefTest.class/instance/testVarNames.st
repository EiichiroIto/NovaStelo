test
testVarNames
	| v |
	v := self newVarDef.
	self assert: v varNames isEmpty.
	v addVariable: 'x'.
	v addVariable: 'y'.
	self assertCollection: v varNames equals: #('x' 'y').