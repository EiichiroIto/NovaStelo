object i/o
initFieldsFrom: anObjStream version: classVersion
	self initFieldsNamed: #(varNames varClasses) from: anObjStream.
	varNames ifNotNil: [ self regularize ]