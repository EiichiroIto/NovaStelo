test
testClearVarNo
	| v varId v1 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v updateVarDef: varId.
	self assert: (v var: v1 at: 1) equals: 0.
	self assert: (v var: v1 at: 2) equals: 0.
	v var: v1 at: 3 put: 3.
	v setVar: v1 toAll: 2.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 2.
	v clearVarNo: v1.
	self assert: (v var: v1 at: 1) equals: 0.
	self assert: (v var: v1 at: 2) equals: 0.