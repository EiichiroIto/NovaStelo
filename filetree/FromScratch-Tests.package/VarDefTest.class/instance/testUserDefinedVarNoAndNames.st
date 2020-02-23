test
testUserDefinedVarNoAndNames
	| v |
	v := self newVarDef .
	v addVariable: 'a'.
	v addVariable: 'b'.
	v addVariable: 'c'.
	self
		assertCollection: v userDefinedVarNoAndNames asArray
		equals: #(#(1 'a') #(2 'b') #(3 'c')).