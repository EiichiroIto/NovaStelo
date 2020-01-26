test
testAddList
	| v x |
	v := self newVarDef.
	x := v addList: 'a'.
	self assert: x equals: 1.
	self assert: v privVarClasses size equals: 1.
	self assert: (v privVarClasses at: 'a') equals: #Array.
	x := v addList: 'b'.
	self assert: x equals: 2.
	self assert: v privVarClasses size equals: 2.
	self assert: (v privVarClasses at: 'b') equals: #Array