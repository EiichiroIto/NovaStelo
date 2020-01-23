test
testVarListRemove
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 at: 1 put: 10.
	v var: v1 list: 1 at: 2 put: 20.
	v var: v1 list: 1 at: 3 put: 30.
	v var: v1 list: 1 remove: 2.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 30