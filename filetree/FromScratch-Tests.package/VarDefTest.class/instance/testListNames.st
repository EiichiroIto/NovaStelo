test
testListNames
	| v ret |
	v := self newVarDef.
	ret := v listNames.
	self assert: ret isEmpty.
	v addList: 'a'.
	v addList: 'b'.
	v addVariable: 'c'.
	ret := v listNames.
	self assertCollection: ret equals: #(a b).