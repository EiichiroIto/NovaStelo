object i/o
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		commandSpec
		argMorphs
		receiver
		selector
		isTimed
	) from: anObjStream.