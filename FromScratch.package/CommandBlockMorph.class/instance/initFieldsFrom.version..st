object i/o
initFieldsFrom: anObjStream version: classVersion

	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(
		commandSpec
		argMorphs
		titleMorph
		receiver
		selector
		isReporter
		isTimed
		wantsName
		wantsPossession
	) from: anObjStream.
