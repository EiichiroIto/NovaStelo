accessing variable
y: bid at: anInteger put: aNumber
	| c x y dy penDown ps ts |
	ps := breeds at: SBreedId patchBreedNo.
	ts := breeds at: bid.
	penDown := ts penDownAt: anInteger.
	c := ts colorAt: anInteger.
	x := ts xAt: anInteger.
	y := ts yAt: anInteger.
	dy := (aNumber - y) sign.
	(aNumber - y) truncated abs
		timesRepeat: [ penDown
				ifTrue: [ ps colorAtPoint: x @ y put: c ].
			y := y + dy.
			y := ps normalize: y ].
	penDown
		ifTrue: [ ps colorAtPoint: x @ y put: c ].
	(y closeTo: aNumber)
		ifFalse: [ y := ps normalize: aNumber ].
	ts yAt: anInteger put: y