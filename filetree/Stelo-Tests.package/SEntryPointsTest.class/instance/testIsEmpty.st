tests-testing
testIsEmpty
	| c |
	c := SEntryPoints new.
	self assert: c isEmpty.
	c addEntryPoint: 2 forBreedNo: 1.
	self deny: c isEmpty.