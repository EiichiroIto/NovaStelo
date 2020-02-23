test
testClear
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 20.
	v var: v2 at: 2 put: 30.
	self assert: (v privVars at: v1) array notEmpty.
	self assert: (v privVars at: v2) array notEmpty.
	v clear.
	self assert: (v privVars at: v1) array isEmpty.
	self assert: (v privVars at: v2) array isEmpty