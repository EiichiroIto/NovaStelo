fixed format-writing
putFloat: anObject id: classID

	firstPass ifTrue: [^ self].
	stream nextPut: classID.
	stream uint32: (anObject basicAt: 1).
	stream uint32: (anObject basicAt: 2).
