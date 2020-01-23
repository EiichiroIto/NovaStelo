object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	variable := self variable.
	self storeFieldsNamed: #(
		variable
	) on: anObjStream.
