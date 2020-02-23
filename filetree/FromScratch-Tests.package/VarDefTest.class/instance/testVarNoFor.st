test
testVarNoFor
	| v a b c |
	v := VarDef new.
	a := v addVariable: 'a'.
	b := v addVariable: 'b'.
	c := v addVariable: 'c'.
	self assert: a ~= b.
	self assert: b ~= c.
	self assert: c ~= a.
	self assert: (v varNoFor: 'a') equals: a.
	self assert: (v varNoFor: 'b') equals: b.
	self assert: (v varNoFor: 'c') equals: c