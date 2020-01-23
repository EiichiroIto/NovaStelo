accessing
list: anInteger1 contains: anObject
	anInteger1 = 0
		ifTrue: [ ^ false ].
	self assureExistsIndex: anInteger1 and: 0.
	^ (array at: anInteger1) includes: anObject