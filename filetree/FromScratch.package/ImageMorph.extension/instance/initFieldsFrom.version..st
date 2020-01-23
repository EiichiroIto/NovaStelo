*FromScratch
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		form
		"transparency"
	) from: anObjStream.
