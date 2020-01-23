test
testAddClassName
	| v x |
	v := self newVarDef.
	x := v add: 'a' className: #Array.
	self assert: x equals: 1.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #Array