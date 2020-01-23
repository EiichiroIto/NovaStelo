object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		labelMorph
	) on: anObjStream.
