tests-initialization
testInitialize
	| br |
	br := SBreed new.
	self assert: br varId class equals: SBreedVarDef.
	self assert: br privVariables class equals: Variables.