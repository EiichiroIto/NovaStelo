object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		nestedBlock
		nextBlock
	) on: anObjStream.
