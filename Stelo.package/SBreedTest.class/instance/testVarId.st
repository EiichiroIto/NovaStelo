tests-private
testVarId
	| obj |
	obj := STurtles new.
	self assert: obj varId class equals: STurtleVarDef.
	obj := SPatches new.
	self assert: obj varId class equals: SPatchVarDef