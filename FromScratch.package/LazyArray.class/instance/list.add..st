accessing
list: anInteger1 add: anObject
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: 0.
	(array at: anInteger1) add: anObject