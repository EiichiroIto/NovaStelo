fixed format-writing
putColor: anObject id: classID

	| a |
	firstPass ifTrue: [^ self].
	stream nextPut: classID.
	stream uint32: anObject privateRGB.
	a := (anObject privateAlpha asInteger min: 255) max: 0.
	stream nextPut: a.