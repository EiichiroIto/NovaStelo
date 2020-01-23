*FromScratch
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		target
		actionSelector
		arguments
		actWhen
	) on: anObjStream.
