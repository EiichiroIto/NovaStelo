fixed format-writing
putRect: anObject id: classID

	firstPass ifFalse: [
		stream nextPut: classID].
	self putField: anObject left.
	self putField: anObject top.
	self putField: anObject right.
	self putField: anObject bottom.
