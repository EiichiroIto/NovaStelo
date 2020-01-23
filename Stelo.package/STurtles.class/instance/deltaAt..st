accessing variable
deltaAt: anInteger
	| h |
	h := self headingAt: anInteger.
	^ Point r: 1.0 degrees: h