object i/o
initFieldsFrom: anObjStream version: classVersion
	self initFieldsNamed: #(varNames classNames) from: anObjStream.
	varNames ifNotNil: [ self regularize ]