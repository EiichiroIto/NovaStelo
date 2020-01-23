fixed format-writing
putBytes: anObject id: classID
	| buf |
	firstPass
		ifTrue: [ ^ self ].
	buf := anObject asByteArray.
	stream nextPut: classID.
	stream uint32: buf size.
	stream nextPutAll: buf.