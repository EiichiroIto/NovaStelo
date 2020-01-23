fixed format-writing
putBigInt: anObject id: classID

	firstPass ifTrue: [^ self].
	stream nextPut: classID.
	stream uint16: anObject digitLength.
	1 to: anObject digitLength do: [:i | stream nextPut: (anObject digitAt: i)].
