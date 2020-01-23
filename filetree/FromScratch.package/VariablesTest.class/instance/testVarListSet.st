test
testVarListSet
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 set: #(10 20 30).
	v var: v1 list: 1 add: 40.
	self assert: (v var: v1 list: 1 at: 1) equals: 10.
	self assert: (v var: v1 list: 1 at: 2) equals: 20.
	self assert: (v var: v1 list: 1 at: 3) equals: 30.
	self assert: (v var: v1 list: 1 at: 4) equals: 40