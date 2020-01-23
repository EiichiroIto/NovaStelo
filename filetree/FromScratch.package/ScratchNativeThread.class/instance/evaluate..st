accessing
evaluate: anInteger
	self pc: anInteger.
	[ self doOneCycle ] whileTrue.
	^ self pop