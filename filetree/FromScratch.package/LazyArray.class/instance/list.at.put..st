accessing
list: anInteger1 at: anInteger2 put: anObject
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: anInteger2.
	(array at: anInteger1) at: anInteger2 put: anObject