object i/o
storeFieldsOn: anObjStream

	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(
		trueBlock
		falseBlock
		nextBlock
	) on: anObjStream.
