*FromScratch
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		orientation
		centering
		hResizing
		vResizing
		inset
	) on: anObjStream.
