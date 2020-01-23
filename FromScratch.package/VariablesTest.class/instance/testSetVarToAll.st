test
testSetVarToAll
	| v varId v1 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v updateVarDef: varId.
	v var: v1 at: 3 put: 3.
	self assert: (v var: v1 at: 1) equals: 0.
	self assert: (v var: v1 at: 2) equals: 0.
	v setVar: v1 toAll: 1.
	self assert: (v var: v1 at: 1) equals: 1.
	self assert: (v var: v1 at: 2) equals: 1.