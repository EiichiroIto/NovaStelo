object i/o
initFieldsFrom: anObjStream version: classVersion
	self
		initFieldsNamed: #(blocksBin project)
		from: anObjStream