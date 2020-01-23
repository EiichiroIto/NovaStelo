test
testVarAt2
	| v varId |
	v := self newVariables.
	varId := self newVarDef.
	varId addVariable: 'a'.
	varId addVariable: 'b'.
	v updateVarDef: varId.
	self assert: (v varAt: 1) isEmpty.
	self assert: (v varAt: 2) isEmpty.
	v privVars at: 1 put: 10.
	v privVars at: 2 put: 20.
	self assert: (v varAt: 1) equals: 10.
	self assert: (v varAt: 2) equals: 20.