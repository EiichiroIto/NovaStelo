misc ops
direction
	| x y d |
	y := self pop.
	x := self pop.
	d := (x closeTo: 0)
		ifTrue: [ y < 0
				ifTrue: [ -90 ]
				ifFalse: [ 90 ] ]
		ifFalse: [ (x @ y) degrees ].
	self push: d.