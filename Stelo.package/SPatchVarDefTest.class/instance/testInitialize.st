tests-initialization
testInitialize
	| v |
	v := SPatchVarDef new.
	self assert: v privVarNames size equals: 4.
	self assert: (v includes: 'color').
	self assert: (v includes: 'screen').
	self assert: (v includes: 'x').
	self assert: (v includes: 'y').