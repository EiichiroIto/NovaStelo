test
testRegularize
	| v |
	v := VarDef new.
	v addReservedVariable: 'x' varNo: 1.
	v addVariable: 'a'.
	v addVariable: 'b'.
	v addVariable: 'c'.
	self assertCollection: v privVarNames asArray equals: #(x a b c).
	v privVarNames: #('a' 'b' 'x' 'c') asOrderedCollection.
	v regularize.
	self assertCollection: v privVarNames asArray equals: #('x' 'a' 'b' 'c')