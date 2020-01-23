object i/o
initFieldsFrom: anObjStream version: classVersion
	self
		initFieldsNamed: #(scripts info)
		from: anObjStream