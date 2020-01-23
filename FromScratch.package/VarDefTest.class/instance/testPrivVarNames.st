test
testPrivVarNames
	| v |
	v := self newVarDef.
	self assert: v privVarNames isNil.
	v privVarNames: #(1 2 3).
	self assertCollection: v privVarNames equals: #(1 2 3).