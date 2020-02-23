tests-initialization
testInitialize
	| v |
	v := STurtleVarDef new.
	self assert: v privVarNames size equals: 5.
	self assert: (v includes: 'color').
	self assert: (v includes: 'flag').
	self assert: (v includes: 'x').
	self assert: (v includes: 'y').
	self assert: (v includes: 'heading').