accessing
at: anInteger put: aValue
	anInteger > self size
		ifTrue: [ aValue = self defaultValue
				ifTrue: [ ^ self ].
			self assureExistsIndex: anInteger.
			self assert: anInteger <= self size ].
	array at: anInteger put: aValue