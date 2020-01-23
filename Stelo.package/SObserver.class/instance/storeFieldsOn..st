object i/o
storeFieldsOn: anObjStream
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(breedId ticks) on: anObjStream.