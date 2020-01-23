test
testDelete
	| v |
	v := self newVarDef.
	v addVariable: 'abc'.
	v addVariable: 'def'.
	v addVariable: 'ghi'.
	self assertCollection: v privVarNames asArray equals: #('abc' 'def' 'ghi').
	v delete: 'abc'.
	self assertCollection: v privVarNames asArray equals: #(nil 'def' 'ghi').