test
testVarListAdd
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 add: 10.
	v var: v1 list: 1 add: 20.
	v var: v1 list: 2 add: 5.
	v var: v1 list: 2 add: 6.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 20.
	self assert: (v var: v1 list: 2 at: 1) equals: 5.
	self assert: (v var: v1 list: 2 at: 2) equals: 6