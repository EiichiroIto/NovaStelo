object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		isBoolean
	) on: anObjStream.
