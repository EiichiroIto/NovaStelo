*FromScratch
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		form
		"transparency"
	) on: anObjStream.
