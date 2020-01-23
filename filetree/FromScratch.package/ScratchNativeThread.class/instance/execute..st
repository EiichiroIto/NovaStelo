accessing
execute: anInteger
	self pc: anInteger.
	[ self doOneCycle ] whileTrue.