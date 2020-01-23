test
testAddReservedVarNoClassName
	| v x |
	v := self newVarDef.
	x := v addReserved: 'b' varNo: 2 className: #ByteArray.
	self assert: x equals: 2.
	self assert: v privClassNames size equals: 1.
	self assert: (v privClassNames at: x) equals: #ByteArray.
	self assert: (v privReservedVarNames includes: 'b')