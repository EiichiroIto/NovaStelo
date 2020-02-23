test
testIsStringVarNo
	| v a b |
	v := self newVarDef.
	a := v addVariable: 'a'.
	b := v add: 'b' className: #StringArray.
	self deny: (v isStringVarNo: a).
	self assert: (v isStringVarNo: b)