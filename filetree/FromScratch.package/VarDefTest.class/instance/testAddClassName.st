test
testAddClassName
	| v x |
	v := self newVarDef.
	x := v add: 'a' className: #Array.
	self assert: x equals: 1.
	self assert: v privVarClasses size equals: 1.
	self assert: (v privVarClasses at: 'a') equals: #Array