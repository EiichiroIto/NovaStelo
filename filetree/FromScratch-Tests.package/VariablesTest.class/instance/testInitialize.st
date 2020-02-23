test
testInitialize
	| v |
	v := self newVariables.
	self assert: v privVarNames isArray.
	self assert: v privVarNames isEmpty.