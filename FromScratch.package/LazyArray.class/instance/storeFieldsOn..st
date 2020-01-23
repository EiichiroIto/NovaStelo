object i/o
storeFieldsOn: anObjStream
	self storeFieldsNamed: #(array className fixedSize defaultValue) on: anObjStream.