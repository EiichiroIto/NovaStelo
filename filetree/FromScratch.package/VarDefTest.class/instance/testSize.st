test
testSize
	| v |
	v := self newVarDef.
	v addVariable: 'x'.
	self assert: v size equals: 1.
	v addVariable: 'y'.
	self assert: v size equals: 2.