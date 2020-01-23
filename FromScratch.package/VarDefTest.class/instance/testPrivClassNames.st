test
testPrivClassNames
	| v |
	v := self newVarDef.
	self assert: v privClassNames isDictionary.
	self assert: v privClassNames isEmpty