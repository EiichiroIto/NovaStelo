accessing
list: anInteger1 set: aCollection
	anInteger1 = 0
		ifTrue: [ ^ self ].
	self assureExistsIndex: anInteger1 and: 0.
	array at: anInteger1 put: aCollection copy asOrderedCollection