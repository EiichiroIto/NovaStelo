testing
hasLocalVar: aString
	^ localVars
		ifNil: [ false ]
		ifNotNil: [ localVars includesKey: aString ]