accessing
assureExistsBreed: aString
	((self scripts collect: #objName) includes: aString)
		ifTrue: [ ^ self ].
	self addNewTurtleScriptNamed: aString