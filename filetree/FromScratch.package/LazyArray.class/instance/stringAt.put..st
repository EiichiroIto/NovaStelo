accessing
stringAt: anInteger put: aString
	self assert: className = #StringArray.
	anInteger > self size
		ifTrue: [ aString = self defaultValue
				ifTrue: [ ^ self ].
			self assureExistsIndex: anInteger.
			self assert: anInteger <= self size ].
	array stringAt: anInteger put: aString