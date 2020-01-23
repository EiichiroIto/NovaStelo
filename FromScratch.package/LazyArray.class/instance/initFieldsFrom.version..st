object i/o
initFieldsFrom: anObjStream version: classVersion
	classVersion = 1
		ifTrue:
			[ self initFieldsNamed: #(array className fixedSize) from: anObjStream ].
	classVersion = 2
		ifTrue: [ self
				initFieldsNamed: #(array className fixedSize defaultValue)
				from: anObjStream ]