test
testVarList
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 set: #(10 20 30).
	v var: v1 list: 1 add: 40.
	self assertCollection: (v var: v1 list: 1) equals: #(10 20 30 40)