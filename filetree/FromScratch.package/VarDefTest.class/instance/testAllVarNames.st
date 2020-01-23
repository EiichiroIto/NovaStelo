test
testAllVarNames
	| v ret |
	v := self newVarDef.
	ret := v allVarNames.
	self assert: ret isEmpty.
	v addVariable: 'a'.
	v addList: 'b'.
	ret := v allVarNames.
	self assertCollection: ret equals: #(a b).