object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		commandSpec
		argMorphs
		titleMorph
		receiver
		selector
		isReporter
		isTimed
		wantsName
		wantsPossession
	) on: anObjStream.
