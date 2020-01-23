test
testForceSize
	| v varId v1 v2 |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	v updateVarDef: varId.
	v var: v1 at: 1 put: 2.
	v var: v1 at: 2 put: 3.
	v var: v2 at: 1 put: 20.
	v var: v2 at: 5 put: 30.
	self assert: (v varAt: v1) fixedSize isNil.
	self assert: (v varAt: v2) fixedSize isNil.
	v forceSize: 10.
	self assert: (v varAt: v1) fixedSize equals: 10.
	self assert: (v varAt: v2) fixedSize equals: 10.
	self assert: (v var: v1 at: 1) equals: 2.
	self assert: (v var: v1 at: 2) equals: 3.
	self assert: (v var: v2 at: 1) equals: 20.
	self assert: (v var: v2 at: 5) equals: 30.
	self assert: (v var: v1 at: 10) equals: 0.
	self assert: (v var: v2 at: 10) equals: 0.