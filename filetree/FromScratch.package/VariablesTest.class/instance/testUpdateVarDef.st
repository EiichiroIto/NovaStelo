test
testUpdateVarDef
	| v varId1 varId2 |
	varId1 := self newVarDef.
	varId1 addVariable: 'a'.
	varId1 addVariable: 'b'.
	varId1 addVariable: 'c'.
	v := self newVariables.
	v updateVarDef: varId1.
	self assertCollection: v privVarNames asArray equals: #('a' 'b' 'c').
	self assert: v privVars isArray.
	self assert: v privVars size equals: 3.
	self assert: (v privVars at: 1) isEmpty.
	self assert: (v privVars at: 2) isEmpty.
	self assert: (v privVars at: 3) isEmpty.
	(v privVars at: 1) setArray: #(0 0 0) asFloatArray.
	(v privVars at: 2) setArray: #(1 2 3) asFloatArray.
	(v privVars at: 3) setArray: #(4 5 6) asFloatArray.
	varId2 := self newVarDef.
	varId2 addVariable: 'c'.
	varId2 addVariable: 'b'.
	varId2 addVariable: 'd'.
	v updateVarDef: varId2.
	self assertCollection: v privVarNames asArray equals: #('c' 'b' 'd').
	self assert: v privVars isArray.
	self assert: v privVars size equals: 3.
	self assert: (v privVars at: 1) privArray equals: #(4 5 6) asFloatArray.
	self assert: (v privVars at: 2) privArray equals: #(1 2 3) asFloatArray.
	self assert: (v privVars at: 3) isEmpty.