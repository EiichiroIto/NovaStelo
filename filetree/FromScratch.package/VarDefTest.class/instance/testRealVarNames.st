test
testRealVarNames
	| v |
	v := VarDef new.
	v addVariable: 'a'.
	v addVariable: 'b'.
	self assertCollection: v realVarNames equals: #(a b).
	v add: 'c' className: nil.
	self assertCollection: v realVarNames equals: #(a b)