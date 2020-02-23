test
testAddVariable
	| v x |
	v := self newVarDef.
	x := v addVariable: 'a'.
	self assert: x equals: 1.
	self assert: v privVarClasses size equals: 1.
	self assert: (v privVarClasses at: 'a') equals: #FloatArray.
	x := v addVariable: 'b'.
	self assert: x equals: 2.
	self assert: v privVarClasses size equals: 2.
	self assert: (v privVarClasses at: 'b') equals: #FloatArray