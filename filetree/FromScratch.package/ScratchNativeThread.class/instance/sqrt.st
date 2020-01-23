arithmetic ops
sqrt
	| x |
	x := self pop.
	x < 0
		ifTrue: [ ^ self errorOccuered ].
	self push: x sqrt.