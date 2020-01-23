object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		menuMorph
		getMenuSelector
		specialValue
	) on: anObjStream.
