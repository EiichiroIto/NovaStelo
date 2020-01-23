tests-initialization
testInitialize
	| ps |
	ps := SPatches new.
	self assert: ps varId class equals: SPatchVarDef.
	self assert: ps privVariables class equals: Variables.
	self assert: ps size equals: 10000.