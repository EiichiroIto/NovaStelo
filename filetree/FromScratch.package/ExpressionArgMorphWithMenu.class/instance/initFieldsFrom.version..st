object i/o
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		menuMorph
		getMenuSelector
	) from: anObjStream.

	classVersion = 1 ifTrue: [^ self].

	"field added in version 2"
	self initFieldsNamed: #(
		specialValue
	) from: anObjStream.
