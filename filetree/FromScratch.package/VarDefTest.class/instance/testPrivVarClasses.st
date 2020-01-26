test
testPrivVarClasses
	| v |
	v := self newVarDef.
	self assert: v privVarClasses isDictionary.
	self assert: v privVarClasses isEmpty