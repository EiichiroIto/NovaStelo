fixed format-writing
putDict: anObject id: classID

	firstPass ifFalse: [
		stream nextPut: classID.
		stream uint32: anObject size].
	anObject associationsDo: [:assoc |
		self putField: assoc key.
		self putField: assoc value].
