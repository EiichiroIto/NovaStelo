object i/o
storeFieldsOn: anObjStream
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(defaultColor #breedNo) on: anObjStream.