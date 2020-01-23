*FromScratch
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		borderWidth
		borderColor
	) from: anObjStream.
