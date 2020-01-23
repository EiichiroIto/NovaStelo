accessing
addEntryPoint: anInteger forBreedNo: bno
	| list |
	list := breeds at: bno ifAbsentPut: [ OrderedCollection new ].
	list add: anInteger.