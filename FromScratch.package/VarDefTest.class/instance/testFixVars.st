test
testFixVars
	| v |
	v := VarDef new.
	v privVarNames: #(a b c b c a) asOrderedCollection.
	self assertCollection: v varNames asArray equals: #(a b c b c a).
	v fixVars.
	self assertCollection: v varNames asArray equals: #(a b c).