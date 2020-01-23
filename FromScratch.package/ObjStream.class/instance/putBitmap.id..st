fixed format-writing
putBitmap: anObject id: classID

	firstPass ifTrue: [^ self].
	stream nextPut: classID.
	stream uint32: anObject size.
	anObject do: [:el | stream uint32: el].
