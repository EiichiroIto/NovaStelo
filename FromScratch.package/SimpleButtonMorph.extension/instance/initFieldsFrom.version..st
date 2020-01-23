*FromScratch
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		target
		actionSelector
		arguments
		actWhen
	) from: anObjStream.
