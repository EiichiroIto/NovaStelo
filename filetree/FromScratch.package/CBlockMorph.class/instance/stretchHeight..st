geometry
stretchHeight: aNumber

	(stretchHeight = aNumber) ifTrue: [^ self].
	stretchHeight := aNumber.
	blockLayoutNeeded := true.
	fullBounds := nil.
	self fixBlockLayout.
