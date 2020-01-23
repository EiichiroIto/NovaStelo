*FromScratch
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		borderWidth
		borderColor
	) on: anObjStream.
