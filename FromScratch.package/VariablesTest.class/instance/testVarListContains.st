test
testVarListContains
	| v varDef v1 |
	v := self newVariables.
	varDef := self newVarDef.
	v1 := varDef addList: 'a'.
	v updateVarDef: varDef.
	v var: v1 list: 1 at: 1 put: 10.
	v var: v1 list: 1 at: 2 put: 20.
	v var: v1 list: 2 at: 1 put: 5.
	v var: v1 list: 2 at: 2 put: 6.
	self assert: (v var: v1 list: 1 contains: 10).
	self assert: (v var: v1 list: 1 contains: 20).
	self deny: (v var: v1 list: 1 contains: 30).
	self assert: (v var: v1 list: 2 contains: 5).
	self assert: (v var: v1 list: 2 contains: 6).
	self deny: (v var: v1 list: 2 contains: 7)