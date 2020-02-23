test
testIsListVarNo
	| v a b c |
	v := self newVarDef.
	a := v addVariable: 'a'.
	b := v addList: 'b'.
	c := v addVariable: 'c'.
	self deny: (v isListVarNo: a).
	self assert: (v isListVarNo: b).
	self deny: (v isListVarNo: c)