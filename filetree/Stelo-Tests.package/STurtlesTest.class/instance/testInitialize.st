tests-initialization
testInitialize
	| ts |
	ts := STurtles new.
	self assert: ts varId class equals: STurtleVarDef.
	self assert: ts privVariables class equals: Variables.
	self assert: ts countAlive equals: 0.