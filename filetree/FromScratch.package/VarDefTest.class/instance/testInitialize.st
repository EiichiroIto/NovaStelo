test
testInitialize
	| v |
	v := self newVarDef.
	self assert: v varNames isEmpty.
	self assert: v privClassNames isDictionary.
	self assert: v privClassNames isEmpty.
	self assert: v privReservedVarNames isCollection.
	self assert: v privReservedVarNames isEmpty