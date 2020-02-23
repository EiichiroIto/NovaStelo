test
testMax
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 30.
	v var: v2 at: 5 put: 20.
	self assert: v max equals: 100