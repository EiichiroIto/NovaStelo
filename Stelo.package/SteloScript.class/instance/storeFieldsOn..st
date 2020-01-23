object i/o
storeFieldsOn: anObjStream
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(breed) on: anObjStream.