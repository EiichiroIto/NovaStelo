object i/o
storeFieldsOn: anObjStream
	self storeFieldsNamed: #(varNames classNames) on: anObjStream.