object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		morph
	) on: anObjStream.
