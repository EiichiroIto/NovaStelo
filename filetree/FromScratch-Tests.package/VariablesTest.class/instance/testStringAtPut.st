test
testStringAtPut
	| vid var v |
	vid := self newVarDef.
	v := vid add: 'a' className: #StringArray.
	var := self newVariables.
	var updateVarDef: vid.
	self assert: (var string: v at: 1) equals: ''.
	self assert: (var string: v at: 2) equals: ''.
	var string: v at: 1 put: 'abc'.
	var string: v at: 2 put: 'def'.
	self assert: (var string: v at: 1) equals: 'abc'.
	self assert: (var string: v at: 2) equals: 'def'