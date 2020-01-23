test
testIsReserved
	| v |
	v := self newVarDef.
	v addReservedVariable: 'b' varNo: 1.
	v addVariable: 'a'.
	self deny: (v isReserved: 'a').
	self assert: (v isReserved: 'b')