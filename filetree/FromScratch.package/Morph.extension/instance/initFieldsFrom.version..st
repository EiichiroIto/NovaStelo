*FromScratch
initFieldsFrom: anObjStream version: classVersion
	"Set my instance variables from the given object stream."

	self initFieldsNamed: #(
		bounds
		owner
		submorphs
		color
		flags
	) from: anObjStream.
	anObjStream nextField.  "placeholder for properties"
	fullBounds := nil.
