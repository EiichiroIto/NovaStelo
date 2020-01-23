fixed format-writing
putPoint: anObject id: classID

	firstPass ifFalse: [
		stream nextPut: classID].
	self putField: anObject x.
	self putField: anObject y.
