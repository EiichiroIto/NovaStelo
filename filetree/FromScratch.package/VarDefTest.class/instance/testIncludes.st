test
testIncludes
	| v |
	v := self newVarDef.
	v addVariable: 'abc'.
	v addVariable: 'def'.
	v addVariable: 'ghi'.
	self assert: (v includes: 'abc').
	self assert: (v includes: 'def').
	self assert: (v includes: 'ghi').
	self assert: (v includes: 'aaa') not.
	self assert: (v includes: 'bbb') not.