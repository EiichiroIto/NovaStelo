tests-accessing
testForBreedNo
	| c l |
	c := SEntryPoints new.
	c addEntryPoint: 1 forBreedNo: 1.
	c addEntryPoint: 4 forBreedNo: 2.
	c addEntryPoint: 7 forBreedNo: 3.
	c addEntryPoint: 10 forBreedNo: 2.
	l := c forBreedNo: 1.
	self assert: l isCollection.
	self assert: l size equals: 1.
	self assertCollection: l asArray equals: #(1).
	l := c forBreedNo: 2.
	self assert: l isCollection.
	self assert: l size equals: 2.
	self assertCollection: l asArray equals: #(4 10).
	l := c forBreedNo: 3.
	self assert: l isCollection.
	self assert: l size equals: 1.
	self assertCollection: l asArray equals: #(7).