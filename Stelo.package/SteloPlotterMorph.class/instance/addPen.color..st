accessing
addPen: anInteger color: aColor
	self ensurePenExists: anInteger.
	pens at: anInteger put: aColor