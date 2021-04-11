api
recursiveLocalVarAt: aString
	(self hasLocalVar: aString)
		ifTrue: [ ^ self localVarAt: aString ].
	^ self parentFrame
		ifNil: [ nil ]
		ifNotNil: [ :frame | frame recursiveLocalVarAt: aString ]