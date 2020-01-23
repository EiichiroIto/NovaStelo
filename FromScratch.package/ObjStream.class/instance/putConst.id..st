fixed format-writing
putConst: anObject id: classID

	firstPass ifTrue: [^ self].
	stream nextPut: classID.
