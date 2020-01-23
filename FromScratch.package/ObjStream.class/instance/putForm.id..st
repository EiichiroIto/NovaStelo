fixed format-writing
putForm: anObject id: classID

	firstPass ifFalse: [stream nextPut: classID].
	anObject hibernate.
	self putField: anObject width.
	self putField: anObject height.
	self putField: anObject depth.
	self putField: anObject privateOffset.
	self putField: anObject bits.
	(anObject class = ColorForm) ifTrue: [self putField: anObject colors].
