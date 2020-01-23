object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		scriptNameMorph
		indicatorMorph
		scriptOwner
		parameters
		isClickable
	) on: anObjStream.
