object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		scriptNameMorph
		indicatorMorph
		scriptOwner
		parameters
	) on: anObjStream.
