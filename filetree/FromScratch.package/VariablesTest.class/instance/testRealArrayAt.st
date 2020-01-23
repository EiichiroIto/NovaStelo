test
testRealArrayAt
	| v varId |
	v := self newVariables.
	varId := self newVarDef.
	varId addVariable: 'a'.
	varId addVariable: 'b'.
	v updateVarDef: varId.
	self assert: (v realArrayAt: 1) isEmpty.
	self assert: (v realArrayAt: 2) isEmpty.
	v var: 1 at: 1 put: 10.
	v var: 2 at: 2 put: 20.
	self assertCollection: (v realArrayAt: 1) size equals: 100.
	self assertCollection: (v realArrayAt: 2) size equals: 100.
	self assert: (v realArrayAt: 1) first equals: 10.0.
	self assert: (v realArrayAt: 1) second equals: 0.0.
	self assert: (v realArrayAt: 2) first equals: 0.0.
	self assert: (v realArrayAt: 2) second equals: 20.0.