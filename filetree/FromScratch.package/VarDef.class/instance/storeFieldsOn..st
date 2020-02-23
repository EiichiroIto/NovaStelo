object i/o
storeFieldsOn: anObjStream
	self storeFieldsNamed: #(varNames varClasses) on: anObjStream.