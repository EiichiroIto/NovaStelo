*FromScratch
storeFieldsOn: anObjStream

	self storeFieldsNamed: #(
		bounds
		owner
		submorphs
		color
		flags
	) on: anObjStream.
	anObjStream putField: nil.  "placeholder for properties"