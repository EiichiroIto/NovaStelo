test
testInitialize
	| v |
	v := self newVarDef.
	self assert: v varNames isEmpty.
	self assert: v privVarClasses isDictionary.
	self assert: v privVarClasses isEmpty.
	self assert: v privReservedVarNames isCollection.
	self assert: v privReservedVarNames isEmpty