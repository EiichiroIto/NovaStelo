object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		commandSpec
		argMorphs
		receiver
		selector
		isTimed
	) on: anObjStream.
