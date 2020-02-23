test
testPrivReservedVarNames
	| v |
	v := VarDef new.
	self assert: v privReservedVarNames isEmpty.
	v privReservedVarNames: 123.
	self assert: v privReservedVarNames equals: 123