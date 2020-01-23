object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		isBoolean
		options
		choice
		getOptionsSelector
	) on: anObjStream.
