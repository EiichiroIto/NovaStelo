arithmetic ops
div
	| x y |
	y := self pop.
	x := self pop.
	(y closeTo: 0)
		ifTrue: [ ^ self errorOccuered ].
	self push: (x / y) asFloat.