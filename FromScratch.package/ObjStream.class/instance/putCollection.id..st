fixed format-writing
putCollection: anObject id: classID

	firstPass ifFalse: [
		stream nextPut: classID.
		stream uint32: anObject size].
	anObject do: [:el | self putField: el].
