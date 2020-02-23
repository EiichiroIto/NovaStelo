test
testSetupVarNames
	| v |
	v := self newVarDef.
	v addReservedVariable: 'a' varNo: 1.
	v addReservedVariable: 'b' varNo: 2.
	self assert: v varNames isEmpty.
	v setupVarNames.
	self assertCollection: v varNames equals: #('a' 'b').
	v := self newVarDef.
	v addReservedVariable: 'a' varNo: 1.
	v addReservedVariable: 'b' varNo: 3.
	self assert: v varNames isEmpty.
	self should: [ v setupVarNames ] raise: Error