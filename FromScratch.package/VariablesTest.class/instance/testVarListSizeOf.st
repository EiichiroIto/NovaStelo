test
testVarListSizeOf
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 set: #(10 20 30).
	self assert: (v var: v1 listSizeOf: 1) equals: 3