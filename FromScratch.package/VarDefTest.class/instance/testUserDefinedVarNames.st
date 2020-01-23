test
testUserDefinedVarNames
	| v ret |
	v := self newVarDef.
	ret := v userDefinedVarNames.
	self assertCollection: ret equals: #().
	v addVariable: 'a'.
	v addVariable: 'b'.
	v addVariable: 'c'.
	ret := v userDefinedVarNames.
	self assertCollection: ret equals: #(a b c).