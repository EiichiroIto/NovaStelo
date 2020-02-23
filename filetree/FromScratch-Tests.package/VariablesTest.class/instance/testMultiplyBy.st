test
testMultiplyBy
	| var varId v1 v2 |
	var := self newVariables.
	varId := self newVarDef.
	v1 := varId addVariable: 'a'.
	v2 := varId addVariable: 'b'.
	var updateVarDef: varId.
	var var: v1 at: 1 put: 10.
	var var: v2 at: 1 put: 20.
	self assert: (var var: v1 at: 1) equals: 10.
	self assert: (var var: v2 at: 1) equals: 20.
	var multiply: v1 by: 2.
	var multiply: v2 by: 3.
	self assert: (var var: v1 at: 1) equals: 20.
	self assert: (var var: v2 at: 1) equals: 60