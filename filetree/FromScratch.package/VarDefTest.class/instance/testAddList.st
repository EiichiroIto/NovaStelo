test
testAddList
	| v x |
	v := self newVarDef.
	x := v addList: 'a'.
	self assert: x equals: 1.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #Array.
	x := v addList: 'b'.
	self assert: x equals: 2.
	self assert: v privClassNames size equals: 2.
	self assert: (v privClassNames at: x) equals: #Array