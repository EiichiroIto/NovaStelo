*FromScratch
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		orientation
		centering
		hResizing
		vResizing
		inset
	) from: anObjStream.