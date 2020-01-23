accessing variable
x: bid at: anInteger put: aNumber
	| c x y dx penDown ps ts |
	ps := breeds at: SBreedId patchBreedNo.
	ts := breeds at: bid.
	penDown := ts penDownAt: anInteger.
	c := ts colorAt: anInteger.
	x := ts xAt: anInteger.
	y := ts yAt: anInteger.
	dx := (aNumber - x) sign.
	(aNumber - x) truncated abs
		timesRepeat: [ penDown
				ifTrue: [ ps colorAtPoint: x @ y put: c ].
			x := x + dx.
			x := ps normalize: x ].
	penDown
		ifTrue: [ ps colorAtPoint: x @ y put: c ].
	(x closeTo: aNumber)
		ifFalse: [ x := ps normalize: aNumber ].
	ts xAt: anInteger put: x