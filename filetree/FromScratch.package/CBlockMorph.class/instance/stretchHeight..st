geometry
stretchHeight: aNumber

	(stretchHeight = aNumber) ifTrue: [^ self].
	stretchHeight := aNumber.
	blockLayoutNeeded := true.
	self fixBlockLayout.
