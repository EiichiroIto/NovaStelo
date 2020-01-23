test
testSetVarToArray
	| v varId v1 a |
	v := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v updateVarDef: varId.
	self assert: (v varAt: v1) isEmpty.
	a := #(1 2 3) asFloatArray.
	v setVar: v1 toArray: a.
	self assertCollection: (v realArrayAt: v1) equals: a.