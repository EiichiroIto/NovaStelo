test
testClassFor
	| v c |
	v := VarDef new.
	v addVariable: 'a'.
	c := v classFor: 'a'.
	self assert: (c isKindOf: LazyArray).
	self assert: c className equals: #FloatArray