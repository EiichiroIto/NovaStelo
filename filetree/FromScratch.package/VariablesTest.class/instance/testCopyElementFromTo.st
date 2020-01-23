test
testCopyElementFromTo
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
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 3.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 2) equals: 30.
	v copyElementFrom: 1 to: 2.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 2.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 2) equals: 20.
	v var: v1 at: 1 put: 4.
	self assert: (v var: v1 at: 1) equals: 4.
	self assert: (v var: v1 at: 2) equals: 2.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 2) equals: 20.