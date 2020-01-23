test
testVarAt
	| vid var v |
	vid := self newVarDef.
	v := vid addVariable: 'a'.
	var := self newVariables.
	var updateVarDef: vid.
	self assert: (var var: v at: 1) equals: 0.
	(var varAt: v) at: 1 put: 1.
	(var varAt: v) at: 2 put: 5.
	self assert: (var var: v at: 1) equals: 1.
	self assert: (var var: v at: 2) equals: 5.